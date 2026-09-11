return {
	Play304021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304021001
		arg_1_1.duration_ = 13.2

		local var_1_0 = {
			zh = 8.3,
			ja = 13.2
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
				arg_1_0:Play304021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A00 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_4_0.name = "A00"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A00 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1019ui_story"].transform

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_1_1.time_ - 1.76666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_14 and arg_1_1.time_ < 1.76666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1019ui_story"]

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_16 and arg_1_1.time_ < 1.76666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.875

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(304021001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 35 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 35)

				if (35 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 35)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021001", "story_v_out_304021.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_304021", "304021001", "story_v_out_304021.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_304021", "304021001", "story_v_out_304021.awb")

						arg_1_1:RecordAudio("304021001", var_4_31)
						arg_1_1:RecordAudio("304021001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304021", "304021001", "story_v_out_304021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304021", "304021001", "story_v_out_304021.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play304021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304021002
		arg_8_1.duration_ = 6.6

		local var_8_0 = {
			zh = 4.166,
			ja = 6.6
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -0.97, -6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1019ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_5.localPosition
			end

			local var_11_6 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_6)
				var_11_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_5.position).x, (manager.ui.mainCamera.transform.position - var_11_5.position).y, (manager.ui.mainCamera.transform.position - var_11_5.position).z)
				var_11_5.localEulerAngles.z = 0
				var_11_5.localEulerAngles.x = 0
				var_11_5.localEulerAngles = var_11_5.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, 100, 0)
				var_11_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_5.position).x, (manager.ui.mainCamera.transform.position - var_11_5.position).y, (manager.ui.mainCamera.transform.position - var_11_5.position).z)
				var_11_5.localEulerAngles.z = 0
				var_11_5.localEulerAngles.x = 0
				var_11_5.localEulerAngles = var_11_5.localEulerAngles
			end

			local var_11_7 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_10 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_11 and not isNil(var_11_10) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_10) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_11)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_11 and arg_8_1.time_ < 0 + var_11_11 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_12 = 0
			local var_11_13 = 0.45

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:GetWordFromCfg(304021002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_17 = 18 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 18)

				if (18 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 18)) > 0 and var_11_13 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021002", "story_v_out_304021.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021002", "story_v_out_304021.awb") / 1000

					if var_11_18 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_12
					end

					if var_11_14.prefab_name ~= "" and arg_8_1.actors_[var_11_14.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_14.prefab_name].transform, "story_v_out_304021", "304021002", "story_v_out_304021.awb")

						arg_8_1:RecordAudio("304021002", var_11_19)
						arg_8_1:RecordAudio("304021002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304021", "304021002", "story_v_out_304021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304021", "304021002", "story_v_out_304021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = math.max(var_11_13, arg_8_1.talkMaxDuration)

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_12) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_12 + var_11_20 and arg_8_1.time_ < var_11_12 + var_11_20 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play304021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304021003
		arg_12_1.duration_ = 7.97

		local var_12_0 = {
			zh = 5.733,
			ja = 7.966
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = arg_12_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(arg_12_1.actors_["1019ui_story"]) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1019ui_story"]) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_4 = arg_12_1.actors_["1019ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_4.localPosition
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_12_1.time_ - 0) / var_15_5)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			local var_15_6 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, 100, 0)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			local var_15_8 = 0
			local var_15_9 = 0.7

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(304021003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 28 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 28)

				if (28 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 28)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021003", "story_v_out_304021.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021003", "story_v_out_304021.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_304021", "304021003", "story_v_out_304021.awb")

						arg_12_1:RecordAudio("304021003", var_15_15)
						arg_12_1:RecordAudio("304021003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304021", "304021003", "story_v_out_304021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304021", "304021003", "story_v_out_304021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play304021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304021004
		arg_16_1.duration_ = 16.1

		local var_16_0 = {
			zh = 13.5,
			ja = 16.1
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.675

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:GetWordFromCfg(304021004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 67 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 67)

				if (67 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 67)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021004", "story_v_out_304021.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021004", "story_v_out_304021.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_304021", "304021004", "story_v_out_304021.awb")

						arg_16_1:RecordAudio("304021004", var_19_6)
						arg_16_1:RecordAudio("304021004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304021", "304021004", "story_v_out_304021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304021", "304021004", "story_v_out_304021.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = arg_20_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(arg_20_1.actors_["1019ui_story"]) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.85

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(304021005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 34 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 34)

				if (34 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 34)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304021006
		arg_24_1.duration_ = 13.5

		local var_24_0 = {
			zh = 7.5,
			ja = 13.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play304021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = arg_24_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(arg_24_1.actors_["1019ui_story"]) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_27_2 = 0
			local var_27_3 = 0.875

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(304021006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 35 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 35)

				if (35 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 35)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021006", "story_v_out_304021.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021006", "story_v_out_304021.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_304021", "304021006", "story_v_out_304021.awb")

						arg_24_1:RecordAudio("304021006", var_27_9)
						arg_24_1:RecordAudio("304021006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304021", "304021006", "story_v_out_304021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304021", "304021006", "story_v_out_304021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304021007
		arg_28_1.duration_ = 8.87

		local var_28_0 = {
			zh = 8.866,
			ja = 7.566
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play304021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.175

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(304021007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 47 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 47)

				if (47 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 47)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021007", "story_v_out_304021.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021007", "story_v_out_304021.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_304021", "304021007", "story_v_out_304021.awb")

						arg_28_1:RecordAudio("304021007", var_31_6)
						arg_28_1:RecordAudio("304021007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304021", "304021007", "story_v_out_304021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304021", "304021007", "story_v_out_304021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304021008
		arg_32_1.duration_ = 13.3

		local var_32_0 = {
			zh = 9.266,
			ja = 13.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play304021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_0 = 0
			local var_35_1 = 1.15

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(304021008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 46 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 46)

				if (46 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 46)) > 0 and var_35_1 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021008", "story_v_out_304021.awb") ~= 0 then
					local var_35_6 = manager.audio:GetVoiceLength("story_v_out_304021", "304021008", "story_v_out_304021.awb") / 1000

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end

					if var_35_2.prefab_name ~= "" and arg_32_1.actors_[var_35_2.prefab_name] ~= nil then
						local var_35_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_2.prefab_name].transform, "story_v_out_304021", "304021008", "story_v_out_304021.awb")

						arg_32_1:RecordAudio("304021008", var_35_7)
						arg_32_1:RecordAudio("304021008", var_35_7)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304021", "304021008", "story_v_out_304021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304021", "304021008", "story_v_out_304021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304021009
		arg_36_1.duration_ = 1

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"

			SetActive(arg_36_1.choicesGo_, true)

			for iter_37_0, iter_37_1 in ipairs(arg_36_1.choices_) do
				SetActive(iter_37_1.go, iter_37_0 <= 2)
			end

			arg_36_1.choices_[1].txt.text = arg_36_1:FormatText(StoryChoiceCfg[1758].name)
			arg_36_1.choices_[2].txt.text = arg_36_1:FormatText(StoryChoiceCfg[1759].name)
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play304021010(arg_36_1)
			end

			if arg_38_0 == 2 then
				arg_36_0:Play304021010(arg_36_1)
			end

			arg_36_1:RecordChoiceLog(304021009, 1758, 1759)
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = arg_36_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(arg_36_1.actors_["1019ui_story"]) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304021010
		arg_40_1.duration_ = 6.8

		local var_40_0 = {
			zh = 6.5,
			ja = 6.8
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play304021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = arg_40_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) then
				if arg_40_1.var_.characterEffect1019ui_story and not isNil(arg_40_1.actors_["1019ui_story"]) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_2 = 0
			local var_43_3 = 0.8

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(304021010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 32 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 32)

				if (32 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 32)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021010", "story_v_out_304021.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021010", "story_v_out_304021.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_304021", "304021010", "story_v_out_304021.awb")

						arg_40_1:RecordAudio("304021010", var_43_9)
						arg_40_1:RecordAudio("304021010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304021", "304021010", "story_v_out_304021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304021", "304021010", "story_v_out_304021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304021011
		arg_44_1.duration_ = 7.23

		local var_44_0 = {
			zh = 5.3,
			ja = 7.233
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_0 = 0
			local var_47_1 = 0.725

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(304021011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 29 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 29)

				if (29 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 29)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021011", "story_v_out_304021.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_out_304021", "304021011", "story_v_out_304021.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_out_304021", "304021011", "story_v_out_304021.awb")

						arg_44_1:RecordAudio("304021011", var_47_7)
						arg_44_1:RecordAudio("304021011", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304021", "304021011", "story_v_out_304021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304021", "304021011", "story_v_out_304021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304021012
		arg_48_1.duration_ = 5

		local var_48_0 = {
			zh = 5,
			ja = 1.999999999999
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = arg_48_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1019ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_1.localPosition
			end

			local var_51_2 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_2)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0, 100, 0)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			local var_51_3 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_6 = arg_48_1.actors_["1019ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_7 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 and not isNil(var_51_6) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_6) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_7)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_8 = 0
			local var_51_9 = 0.325

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(304021012)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 13 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 13)

				if (13 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 13)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021012", "story_v_out_304021.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021012", "story_v_out_304021.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_out_304021", "304021012", "story_v_out_304021.awb")

						arg_48_1:RecordAudio("304021012", var_51_15)
						arg_48_1:RecordAudio("304021012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304021", "304021012", "story_v_out_304021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304021", "304021012", "story_v_out_304021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play304021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304021013
		arg_52_1.duration_ = 7.67

		local var_52_0 = {
			zh = 5,
			ja = 7.666
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play304021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = arg_52_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(arg_52_1.actors_["1084ui_story"]) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_55_1 = arg_52_1.actors_["1084ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_1.localPosition
			end

			local var_55_2 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 then
				var_55_1.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_2)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 then
				var_55_1.localPosition = Vector3.New(0, 100, 0)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			local var_55_3 = 0
			local var_55_4 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_5 = arg_52_1:GetWordFromCfg(304021013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 13 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 13)

				if (13 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 13)) > 0 and var_55_4 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_3
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021013", "story_v_out_304021.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_304021", "304021013", "story_v_out_304021.awb") / 1000

					if var_55_9 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_3
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_304021", "304021013", "story_v_out_304021.awb")

						arg_52_1:RecordAudio("304021013", var_55_10)
						arg_52_1:RecordAudio("304021013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304021", "304021013", "story_v_out_304021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304021", "304021013", "story_v_out_304021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_4, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_3) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_11 and arg_52_1.time_ < var_55_3 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play304021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304021014
		arg_56_1.duration_ = 3.07

		local var_56_0 = {
			zh = 3.066,
			ja = 2.4
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play304021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = arg_56_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).z)
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles = arg_56_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_56_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1019ui_story"].transform.position).z)
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1019ui_story"].transform.localEulerAngles = arg_56_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1019ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_4 = 0
			local var_59_5 = 0.275

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(304021014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 11 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 11)

				if (11 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 11)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021014", "story_v_out_304021.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021014", "story_v_out_304021.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_304021", "304021014", "story_v_out_304021.awb")

						arg_56_1:RecordAudio("304021014", var_59_11)
						arg_56_1:RecordAudio("304021014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304021", "304021014", "story_v_out_304021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304021", "304021014", "story_v_out_304021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304021015
		arg_60_1.duration_ = 2.97

		local var_60_0 = {
			zh = 2.966,
			ja = 2.533
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play304021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_63_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_60_1.stage_.transform)

				var_63_0.name = "1011ui_story"
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1011ui_story"] = var_63_0

				local var_63_1 = var_63_0:GetComponentInChildren(typeof(CharacterEffect))

				var_63_1.enabled = true

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_1.transform, false)

				arg_60_1.var_["1011ui_story" .. "Animator"] = var_63_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_60_1.var_["1011ui_story" .. "LipSync"] = var_63_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_3 = arg_60_1.actors_["1011ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_3.localPosition
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_4)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, 100, 0)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			local var_63_5 = arg_60_1.actors_["1019ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_5.localPosition
			end

			local var_63_6 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 then
				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_6)
				var_63_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_5.position).x, (manager.ui.mainCamera.transform.position - var_63_5.position).y, (manager.ui.mainCamera.transform.position - var_63_5.position).z)
				var_63_5.localEulerAngles.z = 0
				var_63_5.localEulerAngles.x = 0
				var_63_5.localEulerAngles = var_63_5.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0, 100, 0)
				var_63_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_5.position).x, (manager.ui.mainCamera.transform.position - var_63_5.position).y, (manager.ui.mainCamera.transform.position - var_63_5.position).z)
				var_63_5.localEulerAngles.z = 0
				var_63_5.localEulerAngles.x = 0
				var_63_5.localEulerAngles = var_63_5.localEulerAngles
			end

			local var_63_7 = arg_60_1.actors_["1011ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_8 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_8 and not isNil(var_63_7) then
				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_7) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_8 and arg_60_1.time_ < 0 + var_63_8 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_10 = arg_60_1.actors_["1019ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_10) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_11 and not isNil(var_63_10) then
				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_10) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_11)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_11 and arg_60_1.time_ < 0 + var_63_11 + arg_63_0 and not isNil(var_63_10) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_60_1.time_ and arg_60_1.time_ <= 0.1 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			local var_63_13 = 0
			local var_63_14 = 0.175

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_15 = arg_60_1:GetWordFromCfg(304021015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_18 = 7 <= 0 and var_63_14 or var_63_14 * (utf8.len(var_63_16) / 7)

				if (7 <= 0 and var_63_14 or var_63_14 * (utf8.len(var_63_16) / 7)) > 0 and var_63_14 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18

					if var_63_18 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_13
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021015", "story_v_out_304021.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_304021", "304021015", "story_v_out_304021.awb") / 1000

					if var_63_19 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_13
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_304021", "304021015", "story_v_out_304021.awb")

						arg_60_1:RecordAudio("304021015", var_63_20)
						arg_60_1:RecordAudio("304021015", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304021", "304021015", "story_v_out_304021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304021", "304021015", "story_v_out_304021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = math.max(var_63_14, arg_60_1.talkMaxDuration)

			if var_63_13 <= arg_60_1.time_ and arg_60_1.time_ < var_63_13 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_13) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_13 + var_63_21 and arg_60_1.time_ < var_63_13 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play304021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304021016
		arg_64_1.duration_ = 8.63

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.bgs_.S0101 == nil then
				local var_67_0 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0101")
				var_67_0.name = "S0101"
				var_67_0.transform.parent = arg_64_1.stage_.transform
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_.S0101 = var_67_0
			end

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				local var_67_1 = arg_64_1.bgs_.S0101

				arg_64_1.bgs_.S0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_67_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_2 = var_67_1:GetComponent("SpriteRenderer")

				if var_67_2 and var_67_2.sprite then
					local var_67_3 = 2 * (var_67_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_67_1.transform.localScale = Vector3.New(var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "S0101" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_4 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_4 + 0.3 and arg_64_1.time_ < var_67_4 + 0.3 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_5 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_6 = 2

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 then
				local var_67_7 = Color.New(0, 0, 0)

				var_67_7.a = Mathf.Lerp(0, 1, (arg_64_1.time_ - var_67_5) / var_67_6)
				arg_64_1.mask_.color = var_67_7
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 then
				local var_67_8 = Color.New(0, 0, 0)

				var_67_8.a = 1
				arg_64_1.mask_.color = var_67_8
			end

			local var_67_9 = 2

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_10 = 2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 then
				local var_67_11 = Color.New(0, 0, 0)

				var_67_11.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_9) / var_67_10)
				arg_64_1.mask_.color = var_67_11
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 then
				local var_67_12 = Color.New(0, 0, 0)

				arg_64_1.mask_.enabled = false
				var_67_12.a = 0
				arg_64_1.mask_.color = var_67_12
			end

			local var_67_13 = arg_64_1.actors_["1011ui_story"].transform

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_13.localPosition
			end

			local var_67_14 = 0.001

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_14 then
				var_67_13.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 2) / var_67_14)
				var_67_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_13.position).x, (manager.ui.mainCamera.transform.position - var_67_13.position).y, (manager.ui.mainCamera.transform.position - var_67_13.position).z)
				var_67_13.localEulerAngles.z = 0
				var_67_13.localEulerAngles.x = 0
				var_67_13.localEulerAngles = var_67_13.localEulerAngles
			end

			if arg_64_1.time_ >= 2 + var_67_14 and arg_64_1.time_ < 2 + var_67_14 + arg_67_0 then
				var_67_13.localPosition = Vector3.New(0, 100, 0)
				var_67_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_13.position).x, (manager.ui.mainCamera.transform.position - var_67_13.position).y, (manager.ui.mainCamera.transform.position - var_67_13.position).z)
				var_67_13.localEulerAngles.z = 0
				var_67_13.localEulerAngles.x = 0
				var_67_13.localEulerAngles = var_67_13.localEulerAngles
			end

			local var_67_15 = arg_64_1.actors_["1011ui_story"]

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_16 = 0.200000002980232

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_16 and not isNil(var_67_15) then
				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_15) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 2) / var_67_16)
				end
			end

			if arg_64_1.time_ >= 2 + var_67_16 and arg_64_1.time_ < 2 + var_67_16 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_67_17 = arg_64_1.bgs_.S0101.transform

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				arg_64_1.var_.moveOldPosS0101 = var_67_17.localPosition
			end

			local var_67_18 = 2

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_18 then
				var_67_17.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPosS0101, Vector3.New(0, 1.09, 9), (arg_64_1.time_ - 2) / var_67_18)
			end

			if arg_64_1.time_ >= 2 + var_67_18 and arg_64_1.time_ < 2 + var_67_18 + arg_67_0 then
				var_67_17.localPosition = Vector3.New(0, 1.09, 9)
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_19 = 3.63333333333333
			local var_67_20 = 0.6

			if 3.63333333333333 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_21 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_21:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_22 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(304021016).content)

				arg_64_1.text_.text = var_67_22

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_24 = 24 <= 0 and var_67_20 or var_67_20 * (utf8.len(var_67_22) / 24)

				if (24 <= 0 and var_67_20 or var_67_20 * (utf8.len(var_67_22) / 24)) > 0 and var_67_20 < var_67_24 then
					arg_64_1.talkMaxDuration = var_67_24
					var_67_19 = var_67_19 + 0.3

					if var_67_24 + var_67_19 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_19
					end
				end

				arg_64_1.text_.text = var_67_22
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = var_67_19 + 0.3
			local var_67_26 = math.max(var_67_20, arg_64_1.talkMaxDuration)

			if var_67_19 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_25 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_25) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_25 + var_67_26 and arg_64_1.time_ < var_67_25 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0101",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304021017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304021017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304021018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.75

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(304021017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 70 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 70)

				if (70 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 70)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304021018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304021018
		arg_74_1.duration_ = 6.77

		local var_74_0 = {
			zh = 5.433,
			ja = 6.766
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
				arg_74_0:Play304021019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.775

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(304021018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 28 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 28)

				if (28 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 28)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021018", "story_v_out_304021.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021018", "story_v_out_304021.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_304021", "304021018", "story_v_out_304021.awb")

						arg_74_1:RecordAudio("304021018", var_77_6)
						arg_74_1:RecordAudio("304021018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304021", "304021018", "story_v_out_304021.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304021", "304021018", "story_v_out_304021.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304021019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304021019
		arg_78_1.duration_ = 7.67

		local var_78_0 = {
			zh = 7.333,
			ja = 7.666
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
				arg_78_0:Play304021020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = arg_78_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) then
				if arg_78_1.var_.characterEffect1019ui_story and not isNil(arg_78_1.actors_["1019ui_story"]) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_81_1 = 0
			local var_81_2 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(304021019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_6 = 29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_4) / 29)

				if (29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_4) / 29)) > 0 and var_81_2 < var_81_6 then
					arg_78_1.talkMaxDuration = var_81_6

					if var_81_6 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021019", "story_v_out_304021.awb") ~= 0 then
					local var_81_7 = manager.audio:GetVoiceLength("story_v_out_304021", "304021019", "story_v_out_304021.awb") / 1000

					if var_81_7 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_1
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_304021", "304021019", "story_v_out_304021.awb")

						arg_78_1:RecordAudio("304021019", var_81_8)
						arg_78_1:RecordAudio("304021019", var_81_8)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_304021", "304021019", "story_v_out_304021.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_304021", "304021019", "story_v_out_304021.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_9 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_9 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_9

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_9 and arg_78_1.time_ < var_81_1 + var_81_9 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play304021020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304021020
		arg_82_1.duration_ = 1

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"

			SetActive(arg_82_1.choicesGo_, true)

			for iter_83_0, iter_83_1 in ipairs(arg_82_1.choices_) do
				SetActive(iter_83_1.go, iter_83_0 <= 2)
			end

			arg_82_1.choices_[1].txt.text = arg_82_1:FormatText(StoryChoiceCfg[1760].name)
			arg_82_1.choices_[2].txt.text = arg_82_1:FormatText(StoryChoiceCfg[1761].name)
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play304021021(arg_82_1)
			end

			if arg_84_0 == 2 then
				arg_82_0:Play304021022(arg_82_1)
			end

			arg_82_1:RecordChoiceLog(304021020, 1760, 1761)
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			return
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play304021021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304021021
		arg_86_1.duration_ = 8.43

		local var_86_0 = {
			zh = 7,
			ja = 8.433
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
				arg_86_0:Play304021024(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = arg_86_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) then
				if arg_86_1.var_.characterEffect1019ui_story and not isNil(arg_86_1.actors_["1019ui_story"]) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_89_2 = 0
			local var_89_3 = 0.75

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_4 = arg_86_1:GetWordFromCfg(304021021)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 30 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 30)

				if (30 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 30)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021021", "story_v_out_304021.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021021", "story_v_out_304021.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_out_304021", "304021021", "story_v_out_304021.awb")

						arg_86_1:RecordAudio("304021021", var_89_9)
						arg_86_1:RecordAudio("304021021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304021", "304021021", "story_v_out_304021.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304021", "304021021", "story_v_out_304021.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_10 and arg_86_1.time_ < var_89_2 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play304021024 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304021024
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304021025(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) and arg_90_1.var_.characterEffect1011ui_story == nil then
				arg_90_1.var_.characterEffect1011ui_story = arg_90_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) then
				if arg_90_1.var_.characterEffect1011ui_story and not isNil(arg_90_1.actors_["1011ui_story"]) then
					arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) and arg_90_1.var_.characterEffect1011ui_story then
				arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.425

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(304021024).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 17 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 17)

				if (17 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 17)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304021025 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304021025
		arg_94_1.duration_ = 5.3

		local var_94_0 = {
			zh = 5.3,
			ja = 5.033
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
				arg_94_0:Play304021026(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.5

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:GetWordFromCfg(304021025)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 20 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 20)

				if (20 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 20)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021025", "story_v_out_304021.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021025", "story_v_out_304021.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_304021", "304021025", "story_v_out_304021.awb")

						arg_94_1:RecordAudio("304021025", var_97_6)
						arg_94_1:RecordAudio("304021025", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304021", "304021025", "story_v_out_304021.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304021", "304021025", "story_v_out_304021.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304021026 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304021026
		arg_98_1.duration_ = 4.23

		local var_98_0 = {
			zh = 4,
			ja = 4.233
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
				arg_98_0:Play304021027(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.525

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:GetWordFromCfg(304021026)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 21 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 21)

				if (21 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 21)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021026", "story_v_out_304021.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021026", "story_v_out_304021.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_304021", "304021026", "story_v_out_304021.awb")

						arg_98_1:RecordAudio("304021026", var_101_6)
						arg_98_1:RecordAudio("304021026", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304021", "304021026", "story_v_out_304021.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304021", "304021026", "story_v_out_304021.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play304021027 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304021027
		arg_102_1.duration_ = 6.2

		local var_102_0 = {
			zh = 3.9,
			ja = 6.2
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
				arg_102_0:Play304021028(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.475

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(304021027)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 19 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 19)

				if (19 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 19)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021027", "story_v_out_304021.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021027", "story_v_out_304021.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_304021", "304021027", "story_v_out_304021.awb")

						arg_102_1:RecordAudio("304021027", var_105_6)
						arg_102_1:RecordAudio("304021027", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_304021", "304021027", "story_v_out_304021.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_304021", "304021027", "story_v_out_304021.awb")
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
	Play304021028 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 304021028
		arg_106_1.duration_ = 7.27

		local var_106_0 = {
			zh = 6.6,
			ja = 7.266
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
				arg_106_0:Play304021029(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.85

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(304021028)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 34 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 34)

				if (34 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 34)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021028", "story_v_out_304021.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021028", "story_v_out_304021.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_304021", "304021028", "story_v_out_304021.awb")

						arg_106_1:RecordAudio("304021028", var_109_6)
						arg_106_1:RecordAudio("304021028", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_304021", "304021028", "story_v_out_304021.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_304021", "304021028", "story_v_out_304021.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play304021029 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 304021029
		arg_110_1.duration_ = 8.07

		local var_110_0 = {
			zh = 6,
			ja = 8.066
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
				arg_110_0:Play304021030(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.725

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(304021029)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 29 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 29)

				if (29 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 29)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021029", "story_v_out_304021.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021029", "story_v_out_304021.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_304021", "304021029", "story_v_out_304021.awb")

						arg_110_1:RecordAudio("304021029", var_113_6)
						arg_110_1:RecordAudio("304021029", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_304021", "304021029", "story_v_out_304021.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_304021", "304021029", "story_v_out_304021.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play304021030 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 304021030
		arg_114_1.duration_ = 7.41

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play304021031(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 1.325 < arg_114_1.time_ and arg_114_1.time_ <= 1.325 + arg_117_0 then
				local var_117_0 = arg_114_1.bgs_.A00

				arg_114_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_1 = var_117_0:GetComponent("SpriteRenderer")

				if var_117_1 and var_117_1.sprite then
					local var_117_2 = 2 * (var_117_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_0.transform.localScale = Vector3.New(var_117_2 / var_117_1.sprite.bounds.size.y < var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x and var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x or var_117_2 / var_117_1.sprite.bounds.size.y, var_117_2 / var_117_1.sprite.bounds.size.y < var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x and var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x or var_117_2 / var_117_1.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "A00" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_3 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_3 + 0.3 and arg_114_1.time_ < var_117_3 + 0.3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_4 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_5 = 1.325

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_5 then
				local var_117_6 = Color.New(0, 0, 0)

				var_117_6.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_4) / var_117_5)
				arg_114_1.mask_.color = var_117_6
			end

			if arg_114_1.time_ >= var_117_4 + var_117_5 and arg_114_1.time_ < var_117_4 + var_117_5 + arg_117_0 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = 1
				arg_114_1.mask_.color = var_117_7
			end

			local var_117_8 = 1.325

			if 1.325 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_9 = 2

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_9 then
				local var_117_10 = Color.New(0, 0, 0)

				var_117_10.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_8) / var_117_9)
				arg_114_1.mask_.color = var_117_10
			end

			if arg_114_1.time_ >= var_117_8 + var_117_9 and arg_114_1.time_ < var_117_8 + var_117_9 + arg_117_0 then
				local var_117_11 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_11.a = 0
				arg_114_1.mask_.color = var_117_11
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_12 = 2.41302393882846
			local var_117_13 = 0.675

			if 2.41302393882846 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_14 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_14:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(304021030).content)

				arg_114_1.text_.text = var_117_15

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 27 <= 0 and var_117_13 or var_117_13 * (utf8.len(var_117_15) / 27)

				if (27 <= 0 and var_117_13 or var_117_13 * (utf8.len(var_117_15) / 27)) > 0 and var_117_13 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17
					var_117_12 = var_117_12 + 0.3

					if var_117_17 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_15
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = var_117_12 + 0.3
			local var_117_19 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_18) / var_117_19

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play304021031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304021031
		arg_120_1.duration_ = 10.6

		local var_120_0 = {
			zh = 10.033,
			ja = 10.6
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
				arg_120_0:Play304021032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = arg_120_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).z)
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles = arg_120_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_120_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1019ui_story"].transform.position).z)
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1019ui_story"].transform.localEulerAngles = arg_120_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1019ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_4 = 0
			local var_123_5 = 1.35

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(304021031)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 54 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 54)

				if (54 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 54)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021031", "story_v_out_304021.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021031", "story_v_out_304021.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_304021", "304021031", "story_v_out_304021.awb")

						arg_120_1:RecordAudio("304021031", var_123_11)
						arg_120_1:RecordAudio("304021031", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304021", "304021031", "story_v_out_304021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304021", "304021031", "story_v_out_304021.awb")
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
				actorName = "1019ui_story",
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
	Play304021032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304021032
		arg_124_1.duration_ = 7.5

		local var_124_0 = {
			zh = 7.5,
			ja = 5.933
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
				arg_124_0:Play304021033(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.95

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(304021032)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 38 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 38)

				if (38 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 38)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021032", "story_v_out_304021.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021032", "story_v_out_304021.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_304021", "304021032", "story_v_out_304021.awb")

						arg_124_1:RecordAudio("304021032", var_127_6)
						arg_124_1:RecordAudio("304021032", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304021", "304021032", "story_v_out_304021.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304021", "304021032", "story_v_out_304021.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play304021033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304021033
		arg_128_1.duration_ = 11.47

		local var_128_0 = {
			zh = 11.466,
			ja = 11.266
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
				arg_128_0:Play304021034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.425

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(304021033)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 57 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 57)

				if (57 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 57)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021033", "story_v_out_304021.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021033", "story_v_out_304021.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_304021", "304021033", "story_v_out_304021.awb")

						arg_128_1:RecordAudio("304021033", var_131_6)
						arg_128_1:RecordAudio("304021033", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304021", "304021033", "story_v_out_304021.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304021", "304021033", "story_v_out_304021.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304021034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304021034
		arg_132_1.duration_ = 2.23

		local var_132_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_132_0:Play304021035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = arg_132_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1084ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1019ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1019ui_story == nil then
				arg_132_1.var_.characterEffect1019ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_5 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 and not isNil(var_135_4) then
				if arg_132_1.var_.characterEffect1019ui_story and not isNil(var_135_4) then
					arg_132_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_5)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1019ui_story then
				arg_132_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_135_6 = arg_132_1.actors_["1019ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1019ui_story = var_135_6.localPosition
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_6.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_132_1.time_ - 0) / var_135_7)
				var_135_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_6.position).x, (manager.ui.mainCamera.transform.position - var_135_6.position).y, (manager.ui.mainCamera.transform.position - var_135_6.position).z)
				var_135_6.localEulerAngles.z = 0
				var_135_6.localEulerAngles.x = 0
				var_135_6.localEulerAngles = var_135_6.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_135_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_6.position).x, (manager.ui.mainCamera.transform.position - var_135_6.position).y, (manager.ui.mainCamera.transform.position - var_135_6.position).z)
				var_135_6.localEulerAngles.z = 0
				var_135_6.localEulerAngles.x = 0
				var_135_6.localEulerAngles = var_135_6.localEulerAngles
			end

			local var_135_8 = 0
			local var_135_9 = 0.325

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(304021034)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 13 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 13)

				if (13 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 13)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021034", "story_v_out_304021.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021034", "story_v_out_304021.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_304021", "304021034", "story_v_out_304021.awb")

						arg_132_1:RecordAudio("304021034", var_135_15)
						arg_132_1:RecordAudio("304021034", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304021", "304021034", "story_v_out_304021.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304021", "304021034", "story_v_out_304021.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_16 and arg_132_1.time_ < var_135_8 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play304021035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 304021035
		arg_136_1.duration_ = 6.37

		local var_136_0 = {
			zh = 6.233,
			ja = 6.366
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
				arg_136_0:Play304021036(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1019ui_story"]) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = arg_136_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1019ui_story"]) then
				if arg_136_1.var_.characterEffect1019ui_story and not isNil(arg_136_1.actors_["1019ui_story"]) then
					arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1019ui_story"]) and arg_136_1.var_.characterEffect1019ui_story then
				arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1084ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_139_4 = arg_136_1.actors_["1084ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = var_139_4.localPosition
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_4.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_5)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_4.localPosition = Vector3.New(0, 100, 0)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			local var_139_6 = arg_136_1.actors_["1019ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1019ui_story = var_139_6.localPosition
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_6.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_136_1.time_ - 0) / var_139_7)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_139_8 = 0
			local var_139_9 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(304021035)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 38 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 38)

				if (38 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 38)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021035", "story_v_out_304021.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021035", "story_v_out_304021.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_304021", "304021035", "story_v_out_304021.awb")

						arg_136_1:RecordAudio("304021035", var_139_15)
						arg_136_1:RecordAudio("304021035", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_304021", "304021035", "story_v_out_304021.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_304021", "304021035", "story_v_out_304021.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021036 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 304021036
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play304021037(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1019ui_story"]) and arg_140_1.var_.characterEffect1019ui_story == nil then
				arg_140_1.var_.characterEffect1019ui_story = arg_140_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1019ui_story"]) then
				if arg_140_1.var_.characterEffect1019ui_story and not isNil(arg_140_1.actors_["1019ui_story"]) then
					arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1019ui_story"]) and arg_140_1.var_.characterEffect1019ui_story then
				arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_143_1 = arg_140_1.actors_["1084ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, 100, 0)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			local var_143_3 = arg_140_1.actors_["1019ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1019ui_story = var_143_3.localPosition
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_3.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_140_1.time_ - 0) / var_143_4)
				var_143_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_3.position).x, (manager.ui.mainCamera.transform.position - var_143_3.position).y, (manager.ui.mainCamera.transform.position - var_143_3.position).z)
				var_143_3.localEulerAngles.z = 0
				var_143_3.localEulerAngles.x = 0
				var_143_3.localEulerAngles = var_143_3.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_143_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_3.position).x, (manager.ui.mainCamera.transform.position - var_143_3.position).y, (manager.ui.mainCamera.transform.position - var_143_3.position).z)
				var_143_3.localEulerAngles.z = 0
				var_143_3.localEulerAngles.x = 0
				var_143_3.localEulerAngles = var_143_3.localEulerAngles
			end

			local var_143_5 = 0
			local var_143_6 = 0.35

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_7 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(304021036).content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 14 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 14)

				if (14 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 14)) > 0 and var_143_6 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_10 and arg_140_1.time_ < var_143_5 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play304021037 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 304021037
		arg_144_1.duration_ = 8.87

		local var_144_0 = {
			zh = 8.733,
			ja = 8.866
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
				arg_144_0:Play304021038(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = arg_144_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) then
				if arg_144_1.var_.characterEffect1019ui_story and not isNil(arg_144_1.actors_["1019ui_story"]) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_2 = 0
			local var_147_3 = 1.075

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(304021037)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 43 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 43)

				if (43 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 43)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021037", "story_v_out_304021.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021037", "story_v_out_304021.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_304021", "304021037", "story_v_out_304021.awb")

						arg_144_1:RecordAudio("304021037", var_147_9)
						arg_144_1:RecordAudio("304021037", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_304021", "304021037", "story_v_out_304021.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_304021", "304021037", "story_v_out_304021.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play304021038 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 304021038
		arg_148_1.duration_ = 11.13

		local var_148_0 = {
			zh = 11.133,
			ja = 9.733
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play304021039(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1.5

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(304021038)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 60 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 60)

				if (60 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 60)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021038", "story_v_out_304021.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021038", "story_v_out_304021.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_304021", "304021038", "story_v_out_304021.awb")

						arg_148_1:RecordAudio("304021038", var_151_6)
						arg_148_1:RecordAudio("304021038", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_304021", "304021038", "story_v_out_304021.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_304021", "304021038", "story_v_out_304021.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play304021039 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 304021039
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play304021040(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = arg_152_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) then
				if arg_152_1.var_.characterEffect1019ui_story and not isNil(arg_152_1.actors_["1019ui_story"]) then
					arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story then
				arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 0.65

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(304021039).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 26 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 26)

				if (26 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 26)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play304021040 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 304021040
		arg_156_1.duration_ = 9.6

		local var_156_0 = {
			zh = 8.4,
			ja = 9.6
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
				arg_156_0:Play304021041(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1019ui_story"]) and arg_156_1.var_.characterEffect1019ui_story == nil then
				arg_156_1.var_.characterEffect1019ui_story = arg_156_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1019ui_story"]) then
				if arg_156_1.var_.characterEffect1019ui_story and not isNil(arg_156_1.actors_["1019ui_story"]) then
					arg_156_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1019ui_story"]) and arg_156_1.var_.characterEffect1019ui_story then
				arg_156_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_159_2 = 0
			local var_159_3 = 1.05

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_4 = arg_156_1:GetWordFromCfg(304021040)
				local var_159_5 = arg_156_1:FormatText(var_159_4.content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 42 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_5) / 42)

				if (42 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_5) / 42)) > 0 and var_159_3 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021040", "story_v_out_304021.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021040", "story_v_out_304021.awb") / 1000

					if var_159_8 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_2
					end

					if var_159_4.prefab_name ~= "" and arg_156_1.actors_[var_159_4.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_4.prefab_name].transform, "story_v_out_304021", "304021040", "story_v_out_304021.awb")

						arg_156_1:RecordAudio("304021040", var_159_9)
						arg_156_1:RecordAudio("304021040", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_304021", "304021040", "story_v_out_304021.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_304021", "304021040", "story_v_out_304021.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_10 and arg_156_1.time_ < var_159_2 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play304021041 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 304021041
		arg_160_1.duration_ = 2.43

		local var_160_0 = {
			zh = 2.433,
			ja = 2.166
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
				arg_160_0:Play304021042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.275

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(304021041)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 11 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 11)

				if (11 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 11)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021041", "story_v_out_304021.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021041", "story_v_out_304021.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_304021", "304021041", "story_v_out_304021.awb")

						arg_160_1:RecordAudio("304021041", var_163_6)
						arg_160_1:RecordAudio("304021041", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_304021", "304021041", "story_v_out_304021.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_304021", "304021041", "story_v_out_304021.awb")
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
	Play304021042 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 304021042
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play304021043(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) and arg_164_1.var_.characterEffect1019ui_story == nil then
				arg_164_1.var_.characterEffect1019ui_story = arg_164_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) then
				if arg_164_1.var_.characterEffect1019ui_story and not isNil(arg_164_1.actors_["1019ui_story"]) then
					arg_164_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1019ui_story"]) and arg_164_1.var_.characterEffect1019ui_story then
				arg_164_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.5

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(304021042).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 20 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 20)

				if (20 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 20)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play304021043 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 304021043
		arg_168_1.duration_ = 4.7

		local var_168_0 = {
			zh = 4.7,
			ja = 1.999999999999
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
				arg_168_0:Play304021044(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1084ui_story = arg_168_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).z)
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles = arg_168_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_168_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1084ui_story"].transform.position).z)
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1084ui_story"].transform.localEulerAngles = arg_168_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1084ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_171_4 = arg_168_1.actors_["1019ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1019ui_story = var_171_4.localPosition
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_5)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(0, 100, 0)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_6 = 0
			local var_171_7 = 0.55

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(304021043)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 22 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 22)

				if (22 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 22)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021043", "story_v_out_304021.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021043", "story_v_out_304021.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_304021", "304021043", "story_v_out_304021.awb")

						arg_168_1:RecordAudio("304021043", var_171_13)
						arg_168_1:RecordAudio("304021043", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_304021", "304021043", "story_v_out_304021.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_304021", "304021043", "story_v_out_304021.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021044 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 304021044
		arg_172_1.duration_ = 4.1

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play304021045(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1011ui_story = arg_172_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).z)
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles = arg_172_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_172_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1011ui_story"].transform.position).z)
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1011ui_story"].transform.localEulerAngles = arg_172_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1011ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1011ui_story == nil then
				arg_172_1.var_.characterEffect1011ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1011ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1011ui_story then
				arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1084ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_5 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_5 and not isNil(var_175_4) then
				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_4) then
					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_5)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_5 and arg_172_1.time_ < 0 + var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1084ui_story then
				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_175_6 = 0
			local var_175_7 = 0.35

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(304021044)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 14 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 14)

				if (14 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 14)) > 0 and var_175_7 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021044", "story_v_out_304021.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021044", "story_v_out_304021.awb") / 1000

					if var_175_12 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_6
					end

					if var_175_8.prefab_name ~= "" and arg_172_1.actors_[var_175_8.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_8.prefab_name].transform, "story_v_out_304021", "304021044", "story_v_out_304021.awb")

						arg_172_1:RecordAudio("304021044", var_175_13)
						arg_172_1:RecordAudio("304021044", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_304021", "304021044", "story_v_out_304021.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_304021", "304021044", "story_v_out_304021.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play304021045 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304021045
		arg_176_1.duration_ = 9.5

		local var_176_0 = {
			zh = 7.433,
			ja = 9.5
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
				arg_176_0:Play304021046(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = arg_176_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).z)
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles = arg_176_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_176_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1019ui_story"].transform.position).z)
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1019ui_story"].transform.localEulerAngles = arg_176_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1084ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_1.localPosition
			end

			local var_179_2 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 then
				var_179_1.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_2)
				var_179_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_1.position).x, (manager.ui.mainCamera.transform.position - var_179_1.position).y, (manager.ui.mainCamera.transform.position - var_179_1.position).z)
				var_179_1.localEulerAngles.z = 0
				var_179_1.localEulerAngles.x = 0
				var_179_1.localEulerAngles = var_179_1.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 then
				var_179_1.localPosition = Vector3.New(0, 100, 0)
				var_179_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_1.position).x, (manager.ui.mainCamera.transform.position - var_179_1.position).y, (manager.ui.mainCamera.transform.position - var_179_1.position).z)
				var_179_1.localEulerAngles.z = 0
				var_179_1.localEulerAngles.x = 0
				var_179_1.localEulerAngles = var_179_1.localEulerAngles
			end

			local var_179_3 = arg_176_1.actors_["1019ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = var_179_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_4 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 and not isNil(var_179_3) then
				if arg_176_1.var_.characterEffect1019ui_story and not isNil(var_179_3) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_179_6 = arg_176_1.actors_["1011ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1011ui_story == nil then
				arg_176_1.var_.characterEffect1011ui_story = var_179_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_7 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 and not isNil(var_179_6) then
				if arg_176_1.var_.characterEffect1011ui_story and not isNil(var_179_6) then
					arg_176_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_7)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1011ui_story then
				arg_176_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_8 = 0
			local var_179_9 = 0.975

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_10 = arg_176_1:GetWordFromCfg(304021045)
				local var_179_11 = arg_176_1:FormatText(var_179_10.content)

				arg_176_1.text_.text = var_179_11

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 39 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 39)

				if (39 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 39)) > 0 and var_179_9 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_8
					end
				end

				arg_176_1.text_.text = var_179_11
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021045", "story_v_out_304021.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021045", "story_v_out_304021.awb") / 1000

					if var_179_14 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_8
					end

					if var_179_10.prefab_name ~= "" and arg_176_1.actors_[var_179_10.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_10.prefab_name].transform, "story_v_out_304021", "304021045", "story_v_out_304021.awb")

						arg_176_1:RecordAudio("304021045", var_179_15)
						arg_176_1:RecordAudio("304021045", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_304021", "304021045", "story_v_out_304021.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_304021", "304021045", "story_v_out_304021.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_16 and arg_176_1.time_ < var_179_8 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play304021046 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 304021046
		arg_180_1.duration_ = 4.07

		local var_180_0 = {
			zh = 4.066,
			ja = 3.433
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
				arg_180_0:Play304021047(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.45

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:GetWordFromCfg(304021046)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 18 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 18)

				if (18 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 18)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021046", "story_v_out_304021.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021046", "story_v_out_304021.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_304021", "304021046", "story_v_out_304021.awb")

						arg_180_1:RecordAudio("304021046", var_183_6)
						arg_180_1:RecordAudio("304021046", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_304021", "304021046", "story_v_out_304021.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_304021", "304021046", "story_v_out_304021.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play304021047 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 304021047
		arg_184_1.duration_ = 10.53

		local var_184_0 = {
			zh = 5.3,
			ja = 10.533
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
				arg_184_0:Play304021048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1011ui_story"]) and arg_184_1.var_.characterEffect1011ui_story == nil then
				arg_184_1.var_.characterEffect1011ui_story = arg_184_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1011ui_story"]) then
				if arg_184_1.var_.characterEffect1011ui_story and not isNil(arg_184_1.actors_["1011ui_story"]) then
					arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1011ui_story"]) and arg_184_1.var_.characterEffect1011ui_story then
				arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_187_2 = arg_184_1.actors_["1019ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect1019ui_story == nil then
				arg_184_1.var_.characterEffect1019ui_story = var_187_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_3 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.characterEffect1019ui_story and not isNil(var_187_2) then
					arg_184_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_3)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect1019ui_story then
				arg_184_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_187_4 = 0
			local var_187_5 = 0.525

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(304021047)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 21 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 21)

				if (21 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 21)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021047", "story_v_out_304021.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021047", "story_v_out_304021.awb") / 1000

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end

					if var_187_6.prefab_name ~= "" and arg_184_1.actors_[var_187_6.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_6.prefab_name].transform, "story_v_out_304021", "304021047", "story_v_out_304021.awb")

						arg_184_1:RecordAudio("304021047", var_187_11)
						arg_184_1:RecordAudio("304021047", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_304021", "304021047", "story_v_out_304021.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_304021", "304021047", "story_v_out_304021.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_12 and arg_184_1.time_ < var_187_4 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play304021048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 304021048
		arg_188_1.duration_ = 14.03

		local var_188_0 = {
			zh = 10.4,
			ja = 14.033
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
				arg_188_0:Play304021049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1019ui_story"]) and arg_188_1.var_.characterEffect1019ui_story == nil then
				arg_188_1.var_.characterEffect1019ui_story = arg_188_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1019ui_story"]) then
				if arg_188_1.var_.characterEffect1019ui_story and not isNil(arg_188_1.actors_["1019ui_story"]) then
					arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1019ui_story"]) and arg_188_1.var_.characterEffect1019ui_story then
				arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_191_2 = arg_188_1.actors_["1011ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1011ui_story == nil then
				arg_188_1.var_.characterEffect1011ui_story = var_191_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_3 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.characterEffect1011ui_story and not isNil(var_191_2) then
					arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_3)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1011ui_story then
				arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_191_4 = 0
			local var_191_5 = 1.225

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_6 = arg_188_1:GetWordFromCfg(304021048)
				local var_191_7 = arg_188_1:FormatText(var_191_6.content)

				arg_188_1.text_.text = var_191_7

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 49 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 49)

				if (49 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 49)) > 0 and var_191_5 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_4
					end
				end

				arg_188_1.text_.text = var_191_7
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021048", "story_v_out_304021.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021048", "story_v_out_304021.awb") / 1000

					if var_191_10 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_4
					end

					if var_191_6.prefab_name ~= "" and arg_188_1.actors_[var_191_6.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_6.prefab_name].transform, "story_v_out_304021", "304021048", "story_v_out_304021.awb")

						arg_188_1:RecordAudio("304021048", var_191_11)
						arg_188_1:RecordAudio("304021048", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_304021", "304021048", "story_v_out_304021.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_304021", "304021048", "story_v_out_304021.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_5, arg_188_1.talkMaxDuration)

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_4) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_4 + var_191_12 and arg_188_1.time_ < var_191_4 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play304021049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 304021049
		arg_192_1.duration_ = 3.6

		local var_192_0 = {
			zh = 3.6,
			ja = 1.999999999999
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play304021050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_195_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_192_1.stage_.transform)

				var_195_0.name = "1037ui_story"
				var_195_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["1037ui_story"] = var_195_0

				local var_195_1 = var_195_0:GetComponentInChildren(typeof(CharacterEffect))

				var_195_1.enabled = true

				local var_195_2 = GameObjectTools.GetOrAddComponent(var_195_0, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_1.transform, false)

				arg_192_1.var_["1037ui_story" .. "Animator"] = var_195_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_192_1.var_["1037ui_story" .. "LipSync"] = var_195_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_195_3 = arg_192_1.actors_["1037ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1037ui_story = var_195_3.localPosition
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_3.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_192_1.time_ - 0) / var_195_4)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_3.localPosition = Vector3.New(0.7, -1.09, -5.81)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			local var_195_5 = arg_192_1.actors_["1011ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1011ui_story = var_195_5.localPosition
			end

			local var_195_6 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 then
				var_195_5.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_6)
				var_195_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_5.position).x, (manager.ui.mainCamera.transform.position - var_195_5.position).y, (manager.ui.mainCamera.transform.position - var_195_5.position).z)
				var_195_5.localEulerAngles.z = 0
				var_195_5.localEulerAngles.x = 0
				var_195_5.localEulerAngles = var_195_5.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 then
				var_195_5.localPosition = Vector3.New(0, 100, 0)
				var_195_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_5.position).x, (manager.ui.mainCamera.transform.position - var_195_5.position).y, (manager.ui.mainCamera.transform.position - var_195_5.position).z)
				var_195_5.localEulerAngles.z = 0
				var_195_5.localEulerAngles.x = 0
				var_195_5.localEulerAngles = var_195_5.localEulerAngles
			end

			local var_195_7 = arg_192_1.actors_["1037ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.characterEffect1037ui_story == nil then
				arg_192_1.var_.characterEffect1037ui_story = var_195_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_8 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_8 and not isNil(var_195_7) then
				if arg_192_1.var_.characterEffect1037ui_story and not isNil(var_195_7) then
					arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_8 and arg_192_1.time_ < 0 + var_195_8 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.characterEffect1037ui_story then
				arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_195_10 = arg_192_1.actors_["1019ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_10) and arg_192_1.var_.characterEffect1019ui_story == nil then
				arg_192_1.var_.characterEffect1019ui_story = var_195_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_11 and not isNil(var_195_10) then
				if arg_192_1.var_.characterEffect1019ui_story and not isNil(var_195_10) then
					arg_192_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_11)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_11 and arg_192_1.time_ < 0 + var_195_11 + arg_195_0 and not isNil(var_195_10) and arg_192_1.var_.characterEffect1019ui_story then
				arg_192_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_195_12 = 0
			local var_195_13 = 0.3

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_14 = arg_192_1:GetWordFromCfg(304021049)
				local var_195_15 = arg_192_1:FormatText(var_195_14.content)

				arg_192_1.text_.text = var_195_15

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 12 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 12)

				if (12 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 12)) > 0 and var_195_13 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_15
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021049", "story_v_out_304021.awb") ~= 0 then
					local var_195_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021049", "story_v_out_304021.awb") / 1000

					if var_195_18 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_12
					end

					if var_195_14.prefab_name ~= "" and arg_192_1.actors_[var_195_14.prefab_name] ~= nil then
						local var_195_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_14.prefab_name].transform, "story_v_out_304021", "304021049", "story_v_out_304021.awb")

						arg_192_1:RecordAudio("304021049", var_195_19)
						arg_192_1:RecordAudio("304021049", var_195_19)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_304021", "304021049", "story_v_out_304021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_304021", "304021049", "story_v_out_304021.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_20 and arg_192_1.time_ < var_195_12 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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

		arg_192_1:InitPlayNodeList()
	end,
	Play304021050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 304021050
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			zh = 7.6,
			ja = 7.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play304021051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1019ui_story"]) and arg_196_1.var_.characterEffect1019ui_story == nil then
				arg_196_1.var_.characterEffect1019ui_story = arg_196_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1019ui_story"]) then
				if arg_196_1.var_.characterEffect1019ui_story and not isNil(arg_196_1.actors_["1019ui_story"]) then
					arg_196_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1019ui_story"]) and arg_196_1.var_.characterEffect1019ui_story then
				arg_196_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["1037ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1037ui_story == nil then
				arg_196_1.var_.characterEffect1037ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect1037ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1037ui_story then
				arg_196_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_4 = 0
			local var_199_5 = 0.925

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(304021050)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 37 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 37)

				if (37 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 37)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021050", "story_v_out_304021.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021050", "story_v_out_304021.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_304021", "304021050", "story_v_out_304021.awb")

						arg_196_1:RecordAudio("304021050", var_199_11)
						arg_196_1:RecordAudio("304021050", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_304021", "304021050", "story_v_out_304021.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_304021", "304021050", "story_v_out_304021.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play304021051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 304021051
		arg_200_1.duration_ = 5

		local var_200_0 = {
			zh = 5,
			ja = 1.999999999999
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play304021052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1037ui_story"]) and arg_200_1.var_.characterEffect1037ui_story == nil then
				arg_200_1.var_.characterEffect1037ui_story = arg_200_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1037ui_story"]) then
				if arg_200_1.var_.characterEffect1037ui_story and not isNil(arg_200_1.actors_["1037ui_story"]) then
					arg_200_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1037ui_story"]) and arg_200_1.var_.characterEffect1037ui_story then
				arg_200_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_203_2 = arg_200_1.actors_["1019ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = var_203_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_3 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.characterEffect1019ui_story and not isNil(var_203_2) then
					arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_3)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1019ui_story then
				arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_4 = 0
			local var_203_5 = 0.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(304021051)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 16 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 16)

				if (16 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 16)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021051", "story_v_out_304021.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021051", "story_v_out_304021.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_304021", "304021051", "story_v_out_304021.awb")

						arg_200_1:RecordAudio("304021051", var_203_11)
						arg_200_1:RecordAudio("304021051", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_304021", "304021051", "story_v_out_304021.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_304021", "304021051", "story_v_out_304021.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play304021052 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 304021052
		arg_204_1.duration_ = 11.97

		local var_204_0 = {
			zh = 9.566,
			ja = 11.966
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play304021053(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = arg_204_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) then
				if arg_204_1.var_.characterEffect1019ui_story and not isNil(arg_204_1.actors_["1019ui_story"]) then
					arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story then
				arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["1037ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1037ui_story == nil then
				arg_204_1.var_.characterEffect1037ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect1037ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1037ui_story then
				arg_204_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_207_4 = 0
			local var_207_5 = 1.2

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(304021052)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 47 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 47)

				if (47 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 47)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021052", "story_v_out_304021.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021052", "story_v_out_304021.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_304021", "304021052", "story_v_out_304021.awb")

						arg_204_1:RecordAudio("304021052", var_207_11)
						arg_204_1:RecordAudio("304021052", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_304021", "304021052", "story_v_out_304021.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_304021", "304021052", "story_v_out_304021.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play304021053 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 304021053
		arg_208_1.duration_ = 8.5

		local var_208_0 = {
			zh = 6.866,
			ja = 8.5
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
				arg_208_0:Play304021054(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_0 = 0
			local var_211_1 = 0.95

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(304021053)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 38 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 38)

				if (38 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 38)) > 0 and var_211_1 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021053", "story_v_out_304021.awb") ~= 0 then
					local var_211_6 = manager.audio:GetVoiceLength("story_v_out_304021", "304021053", "story_v_out_304021.awb") / 1000

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end

					if var_211_2.prefab_name ~= "" and arg_208_1.actors_[var_211_2.prefab_name] ~= nil then
						local var_211_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_2.prefab_name].transform, "story_v_out_304021", "304021053", "story_v_out_304021.awb")

						arg_208_1:RecordAudio("304021053", var_211_7)
						arg_208_1:RecordAudio("304021053", var_211_7)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_304021", "304021053", "story_v_out_304021.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_304021", "304021053", "story_v_out_304021.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play304021054 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 304021054
		arg_212_1.duration_ = 2.5

		local var_212_0 = {
			zh = 2.5,
			ja = 1.333
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
				arg_212_0:Play304021055(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1037ui_story"]) and arg_212_1.var_.characterEffect1037ui_story == nil then
				arg_212_1.var_.characterEffect1037ui_story = arg_212_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1037ui_story"]) then
				if arg_212_1.var_.characterEffect1037ui_story and not isNil(arg_212_1.actors_["1037ui_story"]) then
					arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1037ui_story"]) and arg_212_1.var_.characterEffect1037ui_story then
				arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_215_2 = arg_212_1.actors_["1019ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1019ui_story == nil then
				arg_212_1.var_.characterEffect1019ui_story = var_215_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_3 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.characterEffect1019ui_story and not isNil(var_215_2) then
					arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_3)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1019ui_story then
				arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_215_4 = 0
			local var_215_5 = 0.1

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(304021054)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 4 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 4)

				if (4 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 4)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021054", "story_v_out_304021.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021054", "story_v_out_304021.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_304021", "304021054", "story_v_out_304021.awb")

						arg_212_1:RecordAudio("304021054", var_215_11)
						arg_212_1:RecordAudio("304021054", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_304021", "304021054", "story_v_out_304021.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_304021", "304021054", "story_v_out_304021.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play304021055 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 304021055
		arg_216_1.duration_ = 16.77

		local var_216_0 = {
			zh = 10.466,
			ja = 16.766
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
				arg_216_0:Play304021056(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1019ui_story"]) and arg_216_1.var_.characterEffect1019ui_story == nil then
				arg_216_1.var_.characterEffect1019ui_story = arg_216_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1019ui_story"]) then
				if arg_216_1.var_.characterEffect1019ui_story and not isNil(arg_216_1.actors_["1019ui_story"]) then
					arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1019ui_story"]) and arg_216_1.var_.characterEffect1019ui_story then
				arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_219_2 = arg_216_1.actors_["1037ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1037ui_story == nil then
				arg_216_1.var_.characterEffect1037ui_story = var_219_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.characterEffect1037ui_story and not isNil(var_219_2) then
					arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_3)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1037ui_story then
				arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_4 = 0
			local var_219_5 = 1.4

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(304021055)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 56 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 56)

				if (56 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 56)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021055", "story_v_out_304021.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021055", "story_v_out_304021.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_304021", "304021055", "story_v_out_304021.awb")

						arg_216_1:RecordAudio("304021055", var_219_11)
						arg_216_1:RecordAudio("304021055", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_304021", "304021055", "story_v_out_304021.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_304021", "304021055", "story_v_out_304021.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play304021056 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 304021056
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			zh = 8.79933333631356,
			ja = 5.533333333332
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
				arg_220_0:Play304021057(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if arg_220_1.bgs_.B13 == nil then
				local var_223_0 = Object.Instantiate(arg_220_1.paintGo_)

				var_223_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_223_0.name = "B13"
				var_223_0.transform.parent = arg_220_1.stage_.transform
				var_223_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.bgs_.B13 = var_223_0
			end

			if 1.8 < arg_220_1.time_ and arg_220_1.time_ <= 1.8 + arg_223_0 then
				local var_223_1 = arg_220_1.bgs_.B13

				arg_220_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_223_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_223_2 = var_223_1:GetComponent("SpriteRenderer")

				if var_223_2 and var_223_2.sprite then
					local var_223_3 = 2 * (var_223_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_223_1.transform.localScale = Vector3.New(var_223_3 / var_223_2.sprite.bounds.size.y < var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x and var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x or var_223_3 / var_223_2.sprite.bounds.size.y, var_223_3 / var_223_2.sprite.bounds.size.y < var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x and var_223_3 * manager.ui.mainCameraCom_.aspect / var_223_2.sprite.bounds.size.x or var_223_3 / var_223_2.sprite.bounds.size.y, 0)
				end

				for iter_223_0, iter_223_1 in pairs(arg_220_1.bgs_) do
					if iter_223_0 ~= "B13" then
						iter_223_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_223_4 = 0

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.allBtn_.enabled = false
			end

			if arg_220_1.time_ >= var_223_4 + 0.3 and arg_220_1.time_ < var_223_4 + 0.3 + arg_223_0 then
				arg_220_1.allBtn_.enabled = true
			end

			local var_223_5 = 0

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_6 = 1.8

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_6 then
				local var_223_7 = Color.New(0, 0, 0)

				var_223_7.a = Mathf.Lerp(0, 1, (arg_220_1.time_ - var_223_5) / var_223_6)
				arg_220_1.mask_.color = var_223_7
			end

			if arg_220_1.time_ >= var_223_5 + var_223_6 and arg_220_1.time_ < var_223_5 + var_223_6 + arg_223_0 then
				local var_223_8 = Color.New(0, 0, 0)

				var_223_8.a = 1
				arg_220_1.mask_.color = var_223_8
			end

			local var_223_9 = 1.8

			if 1.8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_10 = 2.2

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_10 then
				local var_223_11 = Color.New(0, 0, 0)

				var_223_11.a = Mathf.Lerp(1, 0, (arg_220_1.time_ - var_223_9) / var_223_10)
				arg_220_1.mask_.color = var_223_11
			end

			if arg_220_1.time_ >= var_223_9 + var_223_10 and arg_220_1.time_ < var_223_9 + var_223_10 + arg_223_0 then
				local var_223_12 = Color.New(0, 0, 0)

				arg_220_1.mask_.enabled = false
				var_223_12.a = 0
				arg_220_1.mask_.color = var_223_12
			end

			local var_223_13 = arg_220_1.actors_["1084ui_story"].transform

			if 3.53333333333333 < arg_220_1.time_ and arg_220_1.time_ <= 3.53333333333333 + arg_223_0 then
				arg_220_1.var_.moveOldPos1084ui_story = var_223_13.localPosition
			end

			local var_223_14 = 0.001

			if 3.53333333333333 <= arg_220_1.time_ and arg_220_1.time_ < 3.53333333333333 + var_223_14 then
				var_223_13.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_220_1.time_ - 3.53333333333333) / var_223_14)
				var_223_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_13.position).x, (manager.ui.mainCamera.transform.position - var_223_13.position).y, (manager.ui.mainCamera.transform.position - var_223_13.position).z)
				var_223_13.localEulerAngles.z = 0
				var_223_13.localEulerAngles.x = 0
				var_223_13.localEulerAngles = var_223_13.localEulerAngles
			end

			if arg_220_1.time_ >= 3.53333333333333 + var_223_14 and arg_220_1.time_ < 3.53333333333333 + var_223_14 + arg_223_0 then
				var_223_13.localPosition = Vector3.New(0, -0.97, -6)
				var_223_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_13.position).x, (manager.ui.mainCamera.transform.position - var_223_13.position).y, (manager.ui.mainCamera.transform.position - var_223_13.position).z)
				var_223_13.localEulerAngles.z = 0
				var_223_13.localEulerAngles.x = 0
				var_223_13.localEulerAngles = var_223_13.localEulerAngles
			end

			local var_223_15 = arg_220_1.actors_["1037ui_story"].transform

			if 1.8 < arg_220_1.time_ and arg_220_1.time_ <= 1.8 + arg_223_0 then
				arg_220_1.var_.moveOldPos1037ui_story = var_223_15.localPosition
			end

			local var_223_16 = 0.001

			if 1.8 <= arg_220_1.time_ and arg_220_1.time_ < 1.8 + var_223_16 then
				var_223_15.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 1.8) / var_223_16)
				var_223_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_15.position).x, (manager.ui.mainCamera.transform.position - var_223_15.position).y, (manager.ui.mainCamera.transform.position - var_223_15.position).z)
				var_223_15.localEulerAngles.z = 0
				var_223_15.localEulerAngles.x = 0
				var_223_15.localEulerAngles = var_223_15.localEulerAngles
			end

			if arg_220_1.time_ >= 1.8 + var_223_16 and arg_220_1.time_ < 1.8 + var_223_16 + arg_223_0 then
				var_223_15.localPosition = Vector3.New(0, 100, 0)
				var_223_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_15.position).x, (manager.ui.mainCamera.transform.position - var_223_15.position).y, (manager.ui.mainCamera.transform.position - var_223_15.position).z)
				var_223_15.localEulerAngles.z = 0
				var_223_15.localEulerAngles.x = 0
				var_223_15.localEulerAngles = var_223_15.localEulerAngles
			end

			local var_223_17 = arg_220_1.actors_["1084ui_story"]

			if 3.53333333333333 < arg_220_1.time_ and arg_220_1.time_ <= 3.53333333333333 + arg_223_0 and not isNil(var_223_17) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_18 = 0.200000002980232

			if 3.53333333333333 <= arg_220_1.time_ and arg_220_1.time_ < 3.53333333333333 + var_223_18 and not isNil(var_223_17) then
				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_17) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 3.53333333333333 + var_223_18 and arg_220_1.time_ < 3.53333333333333 + var_223_18 + arg_223_0 and not isNil(var_223_17) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_223_20 = arg_220_1.actors_["1019ui_story"]

			if 3.53333333333333 < arg_220_1.time_ and arg_220_1.time_ <= 3.53333333333333 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1019ui_story == nil then
				arg_220_1.var_.characterEffect1019ui_story = var_223_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_21 = 0.200000002980232

			if 3.53333333333333 <= arg_220_1.time_ and arg_220_1.time_ < 3.53333333333333 + var_223_21 and not isNil(var_223_20) then
				if arg_220_1.var_.characterEffect1019ui_story and not isNil(var_223_20) then
					arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 3.53333333333333) / var_223_21)
				end
			end

			if arg_220_1.time_ >= 3.53333333333333 + var_223_21 and arg_220_1.time_ < 3.53333333333333 + var_223_21 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1019ui_story then
				arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 3.53333333333333 < arg_220_1.time_ and arg_220_1.time_ <= 3.53333333333333 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 3.53333333333333 < arg_220_1.time_ and arg_220_1.time_ <= 3.53333333333333 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_223_22 = arg_220_1.actors_["1037ui_story"].transform

			if 1.8 < arg_220_1.time_ and arg_220_1.time_ <= 1.8 + arg_223_0 then
				arg_220_1.var_.moveOldPos1037ui_story = var_223_22.localPosition
			end

			local var_223_23 = 0.001

			if 1.8 <= arg_220_1.time_ and arg_220_1.time_ < 1.8 + var_223_23 then
				var_223_22.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 1.8) / var_223_23)
				var_223_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_22.position).x, (manager.ui.mainCamera.transform.position - var_223_22.position).y, (manager.ui.mainCamera.transform.position - var_223_22.position).z)
				var_223_22.localEulerAngles.z = 0
				var_223_22.localEulerAngles.x = 0
				var_223_22.localEulerAngles = var_223_22.localEulerAngles
			end

			if arg_220_1.time_ >= 1.8 + var_223_23 and arg_220_1.time_ < 1.8 + var_223_23 + arg_223_0 then
				var_223_22.localPosition = Vector3.New(0, 100, 0)
				var_223_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_22.position).x, (manager.ui.mainCamera.transform.position - var_223_22.position).y, (manager.ui.mainCamera.transform.position - var_223_22.position).z)
				var_223_22.localEulerAngles.z = 0
				var_223_22.localEulerAngles.x = 0
				var_223_22.localEulerAngles = var_223_22.localEulerAngles
			end

			local var_223_24 = arg_220_1.actors_["1019ui_story"].transform

			if 1.8 < arg_220_1.time_ and arg_220_1.time_ <= 1.8 + arg_223_0 then
				arg_220_1.var_.moveOldPos1019ui_story = var_223_24.localPosition
			end

			local var_223_25 = 0.001

			if 1.8 <= arg_220_1.time_ and arg_220_1.time_ < 1.8 + var_223_25 then
				var_223_24.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 1.8) / var_223_25)
				var_223_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_24.position).x, (manager.ui.mainCamera.transform.position - var_223_24.position).y, (manager.ui.mainCamera.transform.position - var_223_24.position).z)
				var_223_24.localEulerAngles.z = 0
				var_223_24.localEulerAngles.x = 0
				var_223_24.localEulerAngles = var_223_24.localEulerAngles
			end

			if arg_220_1.time_ >= 1.8 + var_223_25 and arg_220_1.time_ < 1.8 + var_223_25 + arg_223_0 then
				var_223_24.localPosition = Vector3.New(0, 100, 0)
				var_223_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_24.position).x, (manager.ui.mainCamera.transform.position - var_223_24.position).y, (manager.ui.mainCamera.transform.position - var_223_24.position).z)
				var_223_24.localEulerAngles.z = 0
				var_223_24.localEulerAngles.x = 0
				var_223_24.localEulerAngles = var_223_24.localEulerAngles
			end

			if 1.2 < arg_220_1.time_ and arg_220_1.time_ <= 1.2 + arg_223_0 then
				arg_220_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0.2 < arg_220_1.time_ and arg_220_1.time_ <= 0.2 + arg_223_0 then
				arg_220_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_28 = 3.73333333631356
			local var_223_29 = 0.7

			if 3.73333333631356 < arg_220_1.time_ and arg_220_1.time_ <= var_223_28 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_30 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_30:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_31 = arg_220_1:GetWordFromCfg(304021056)
				local var_223_32 = arg_220_1:FormatText(var_223_31.content)

				arg_220_1.text_.text = var_223_32

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_34 = 28 <= 0 and var_223_29 or var_223_29 * (utf8.len(var_223_32) / 28)

				if (28 <= 0 and var_223_29 or var_223_29 * (utf8.len(var_223_32) / 28)) > 0 and var_223_29 < var_223_34 then
					arg_220_1.talkMaxDuration = var_223_34
					var_223_28 = var_223_28 + 0.3

					if var_223_34 + var_223_28 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_34 + var_223_28
					end
				end

				arg_220_1.text_.text = var_223_32
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021056", "story_v_out_304021.awb") ~= 0 then
					local var_223_35 = manager.audio:GetVoiceLength("story_v_out_304021", "304021056", "story_v_out_304021.awb") / 1000

					if var_223_35 + var_223_28 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_35 + var_223_28
					end

					if var_223_31.prefab_name ~= "" and arg_220_1.actors_[var_223_31.prefab_name] ~= nil then
						local var_223_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_31.prefab_name].transform, "story_v_out_304021", "304021056", "story_v_out_304021.awb")

						arg_220_1:RecordAudio("304021056", var_223_36)
						arg_220_1:RecordAudio("304021056", var_223_36)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_304021", "304021056", "story_v_out_304021.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_304021", "304021056", "story_v_out_304021.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_37 = var_223_28 + 0.3
			local var_223_38 = math.max(var_223_29, arg_220_1.talkMaxDuration)

			if var_223_28 + 0.3 <= arg_220_1.time_ and arg_220_1.time_ < var_223_37 + var_223_38 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_37) / var_223_38

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_37 + var_223_38 and arg_220_1.time_ < var_223_37 + var_223_38 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play304021057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 304021057
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play304021058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1084ui_story"]) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = arg_226_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1084ui_story"]) then
				if arg_226_1.var_.characterEffect1084ui_story and not isNil(arg_226_1.actors_["1084ui_story"]) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1084ui_story"]) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.275

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(304021057).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 11 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 11)

				if (11 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 11)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play304021058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 304021058
		arg_230_1.duration_ = 6.27

		local var_230_0 = {
			zh = 6.266,
			ja = 1.333
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play304021059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = arg_230_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) then
				if arg_230_1.var_.characterEffect1084ui_story and not isNil(arg_230_1.actors_["1084ui_story"]) then
					arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1084ui_story"]) and arg_230_1.var_.characterEffect1084ui_story then
				arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_233_2 = 0
			local var_233_3 = 0.825

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(304021058)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 33 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 33)

				if (33 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 33)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021058", "story_v_out_304021.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021058", "story_v_out_304021.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_304021", "304021058", "story_v_out_304021.awb")

						arg_230_1:RecordAudio("304021058", var_233_9)
						arg_230_1:RecordAudio("304021058", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_304021", "304021058", "story_v_out_304021.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_304021", "304021058", "story_v_out_304021.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play304021059 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 304021059
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play304021060(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = arg_234_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) then
				if arg_234_1.var_.characterEffect1084ui_story and not isNil(arg_234_1.actors_["1084ui_story"]) then
					arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1084ui_story"]) and arg_234_1.var_.characterEffect1084ui_story then
				arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 1.1

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(304021059).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 44 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 44)

				if (44 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 44)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play304021060 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 304021060
		arg_238_1.duration_ = 6.57

		local var_238_0 = {
			zh = 6.566,
			ja = 1.999999999999
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play304021061(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = arg_238_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) then
				if arg_238_1.var_.characterEffect1084ui_story and not isNil(arg_238_1.actors_["1084ui_story"]) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action482")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_2 = 0
			local var_241_3 = 0.75

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(304021060)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 30 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 30)

				if (30 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 30)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021060", "story_v_out_304021.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021060", "story_v_out_304021.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_304021", "304021060", "story_v_out_304021.awb")

						arg_238_1:RecordAudio("304021060", var_241_9)
						arg_238_1:RecordAudio("304021060", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_304021", "304021060", "story_v_out_304021.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_304021", "304021060", "story_v_out_304021.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play304021061 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 304021061
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play304021062(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = arg_242_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) then
				if arg_242_1.var_.characterEffect1084ui_story and not isNil(arg_242_1.actors_["1084ui_story"]) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.625

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(304021061).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 25 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 25)

				if (25 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 25)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play304021062 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 304021062
		arg_246_1.duration_ = 7.1

		local var_246_0 = {
			zh = 7.1,
			ja = 4.666
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play304021063(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1011ui_story = arg_246_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).z)
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles = arg_246_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_246_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1011ui_story"].transform.position).z)
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1011ui_story"].transform.localEulerAngles = arg_246_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1084ui_story"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = var_249_1.localPosition
			end

			local var_249_2 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 then
				var_249_1.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_2)
				var_249_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_1.position).x, (manager.ui.mainCamera.transform.position - var_249_1.position).y, (manager.ui.mainCamera.transform.position - var_249_1.position).z)
				var_249_1.localEulerAngles.z = 0
				var_249_1.localEulerAngles.x = 0
				var_249_1.localEulerAngles = var_249_1.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 then
				var_249_1.localPosition = Vector3.New(0, 100, 0)
				var_249_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_1.position).x, (manager.ui.mainCamera.transform.position - var_249_1.position).y, (manager.ui.mainCamera.transform.position - var_249_1.position).z)
				var_249_1.localEulerAngles.z = 0
				var_249_1.localEulerAngles.x = 0
				var_249_1.localEulerAngles = var_249_1.localEulerAngles
			end

			local var_249_3 = arg_246_1.actors_["1011ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1011ui_story == nil then
				arg_246_1.var_.characterEffect1011ui_story = var_249_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_4 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 and not isNil(var_249_3) then
				if arg_246_1.var_.characterEffect1011ui_story and not isNil(var_249_3) then
					arg_246_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1011ui_story then
				arg_246_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_249_6 = 0
			local var_249_7 = 0.7

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:GetWordFromCfg(304021062)
				local var_249_9 = arg_246_1:FormatText(var_249_8.content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 28 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 28)

				if (28 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 28)) > 0 and var_249_7 < var_249_11 then
					arg_246_1.talkMaxDuration = var_249_11

					if var_249_11 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_11 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021062", "story_v_out_304021.awb") ~= 0 then
					local var_249_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021062", "story_v_out_304021.awb") / 1000

					if var_249_12 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_12 + var_249_6
					end

					if var_249_8.prefab_name ~= "" and arg_246_1.actors_[var_249_8.prefab_name] ~= nil then
						local var_249_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_8.prefab_name].transform, "story_v_out_304021", "304021062", "story_v_out_304021.awb")

						arg_246_1:RecordAudio("304021062", var_249_13)
						arg_246_1:RecordAudio("304021062", var_249_13)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_304021", "304021062", "story_v_out_304021.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_304021", "304021062", "story_v_out_304021.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play304021063 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 304021063
		arg_250_1.duration_ = 7.37

		local var_250_0 = {
			zh = 7.366,
			ja = 6.6
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play304021064(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.725

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(304021063)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 29 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 29)

				if (29 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 29)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021063", "story_v_out_304021.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021063", "story_v_out_304021.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_304021", "304021063", "story_v_out_304021.awb")

						arg_250_1:RecordAudio("304021063", var_253_6)
						arg_250_1:RecordAudio("304021063", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_304021", "304021063", "story_v_out_304021.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_304021", "304021063", "story_v_out_304021.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play304021064 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 304021064
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play304021065(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1011ui_story"]) and arg_254_1.var_.characterEffect1011ui_story == nil then
				arg_254_1.var_.characterEffect1011ui_story = arg_254_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1011ui_story"]) then
				if arg_254_1.var_.characterEffect1011ui_story and not isNil(arg_254_1.actors_["1011ui_story"]) then
					arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1011ui_story"]) and arg_254_1.var_.characterEffect1011ui_story then
				arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0
			local var_257_2 = 0.65

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(304021064).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 26 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 26)

				if (26 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 26)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play304021065 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 304021065
		arg_258_1.duration_ = 8.13

		local var_258_0 = {
			zh = 7.866,
			ja = 8.133
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play304021066(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1011ui_story"]) and arg_258_1.var_.characterEffect1011ui_story == nil then
				arg_258_1.var_.characterEffect1011ui_story = arg_258_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1011ui_story"]) then
				if arg_258_1.var_.characterEffect1011ui_story and not isNil(arg_258_1.actors_["1011ui_story"]) then
					arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1011ui_story"]) and arg_258_1.var_.characterEffect1011ui_story then
				arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_261_2 = 0
			local var_261_3 = 0.725

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:GetWordFromCfg(304021065)
				local var_261_5 = arg_258_1:FormatText(var_261_4.content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 29 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 29)

				if (29 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 29)) > 0 and var_261_3 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021065", "story_v_out_304021.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021065", "story_v_out_304021.awb") / 1000

					if var_261_8 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_2
					end

					if var_261_4.prefab_name ~= "" and arg_258_1.actors_[var_261_4.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_4.prefab_name].transform, "story_v_out_304021", "304021065", "story_v_out_304021.awb")

						arg_258_1:RecordAudio("304021065", var_261_9)
						arg_258_1:RecordAudio("304021065", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_304021", "304021065", "story_v_out_304021.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_304021", "304021065", "story_v_out_304021.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_10 and arg_258_1.time_ < var_261_2 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play304021066 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 304021066
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play304021067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1011ui_story"]) and arg_262_1.var_.characterEffect1011ui_story == nil then
				arg_262_1.var_.characterEffect1011ui_story = arg_262_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1011ui_story"]) then
				if arg_262_1.var_.characterEffect1011ui_story and not isNil(arg_262_1.actors_["1011ui_story"]) then
					arg_262_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1011ui_story"]) and arg_262_1.var_.characterEffect1011ui_story then
				arg_262_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_265_1 = 0
			local var_265_2 = 0.2

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(304021066).content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 8 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 8)

				if (8 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 8)) > 0 and var_265_2 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_6 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_6 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_6

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_6 and arg_262_1.time_ < var_265_1 + var_265_6 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play304021067 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 304021067
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play304021068(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1011ui_story = arg_266_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).z)
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles = arg_266_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1011ui_story"].transform.position).z)
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1011ui_story"].transform.localEulerAngles = arg_266_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_269_1 = 0
			local var_269_2 = 1.4

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(304021067).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 56 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 56)

				if (56 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 56)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play304021068 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 304021068
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play304021069(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.375

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(304021068).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 15 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 15)

				if (15 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 15)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play304021069 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 304021069
		arg_274_1.duration_ = 5.7

		local var_274_0 = {
			zh = 5.7,
			ja = 1.999999999999
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
				arg_274_0:Play304021070(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1037ui_story = arg_274_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).z)
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles = arg_274_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_274_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1037ui_story"].transform.position).z)
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1037ui_story"].transform.localEulerAngles = arg_274_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1037ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1037ui_story == nil then
				arg_274_1.var_.characterEffect1037ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect1037ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1037ui_story then
				arg_274_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_4 = 0
			local var_277_5 = 0.8

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(304021069)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 32 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 32)

				if (32 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 32)) > 0 and var_277_5 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021069", "story_v_out_304021.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021069", "story_v_out_304021.awb") / 1000

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end

					if var_277_6.prefab_name ~= "" and arg_274_1.actors_[var_277_6.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_6.prefab_name].transform, "story_v_out_304021", "304021069", "story_v_out_304021.awb")

						arg_274_1:RecordAudio("304021069", var_277_11)
						arg_274_1:RecordAudio("304021069", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_304021", "304021069", "story_v_out_304021.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_304021", "304021069", "story_v_out_304021.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_12 and arg_274_1.time_ < var_277_4 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304021070 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 304021070
		arg_278_1.duration_ = 8.8

		local var_278_0 = {
			zh = 8.8,
			ja = 1.333
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
				arg_278_0:Play304021071(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.925

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:GetWordFromCfg(304021070)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 37 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 37)

				if (37 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 37)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021070", "story_v_out_304021.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021070", "story_v_out_304021.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_304021", "304021070", "story_v_out_304021.awb")

						arg_278_1:RecordAudio("304021070", var_281_6)
						arg_278_1:RecordAudio("304021070", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_304021", "304021070", "story_v_out_304021.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_304021", "304021070", "story_v_out_304021.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play304021071 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 304021071
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play304021072(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1037ui_story"]) and arg_282_1.var_.characterEffect1037ui_story == nil then
				arg_282_1.var_.characterEffect1037ui_story = arg_282_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1037ui_story"]) then
				if arg_282_1.var_.characterEffect1037ui_story and not isNil(arg_282_1.actors_["1037ui_story"]) then
					arg_282_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1037ui_story"]) and arg_282_1.var_.characterEffect1037ui_story then
				arg_282_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 0.3

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(304021071).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 12 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 12)

				if (12 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 12)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play304021072 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 304021072
		arg_286_1.duration_ = 7.57

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play304021073(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if arg_286_1.bgs_.STblack == nil then
				local var_289_0 = Object.Instantiate(arg_286_1.paintGo_)

				var_289_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_289_0.name = "STblack"
				var_289_0.transform.parent = arg_286_1.stage_.transform
				var_289_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.bgs_.STblack = var_289_0
			end

			if 1.2 < arg_286_1.time_ and arg_286_1.time_ <= 1.2 + arg_289_0 then
				local var_289_1 = arg_286_1.bgs_.STblack

				arg_286_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_2 = var_289_1:GetComponent("SpriteRenderer")

				if var_289_2 and var_289_2.sprite then
					local var_289_3 = 2 * (var_289_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_1.transform.localScale = Vector3.New(var_289_3 / var_289_2.sprite.bounds.size.y < var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x and var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x or var_289_3 / var_289_2.sprite.bounds.size.y, var_289_3 / var_289_2.sprite.bounds.size.y < var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x and var_289_3 * manager.ui.mainCameraCom_.aspect / var_289_2.sprite.bounds.size.x or var_289_3 / var_289_2.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "STblack" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_4 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= var_289_4 + 0.3 and arg_286_1.time_ < var_289_4 + 0.3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_5 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_6 = 1.2

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_6 then
				local var_289_7 = Color.New(0, 0, 0)

				var_289_7.a = Mathf.Lerp(0, 1, (arg_286_1.time_ - var_289_5) / var_289_6)
				arg_286_1.mask_.color = var_289_7
			end

			if arg_286_1.time_ >= var_289_5 + var_289_6 and arg_286_1.time_ < var_289_5 + var_289_6 + arg_289_0 then
				local var_289_8 = Color.New(0, 0, 0)

				var_289_8.a = 1
				arg_286_1.mask_.color = var_289_8
			end

			local var_289_9 = 1.2

			if 1.2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_10 = 1.6

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_10 then
				local var_289_11 = Color.New(0, 0, 0)

				var_289_11.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_9) / var_289_10)
				arg_286_1.mask_.color = var_289_11
			end

			if arg_286_1.time_ >= var_289_9 + var_289_10 and arg_286_1.time_ < var_289_9 + var_289_10 + arg_289_0 then
				local var_289_12 = Color.New(0, 0, 0)

				arg_286_1.mask_.enabled = false
				var_289_12.a = 0
				arg_286_1.mask_.color = var_289_12
			end

			local var_289_13 = arg_286_1.actors_["1037ui_story"].transform

			if 1.2 < arg_286_1.time_ and arg_286_1.time_ <= 1.2 + arg_289_0 then
				arg_286_1.var_.moveOldPos1037ui_story = var_289_13.localPosition
			end

			local var_289_14 = 0.001

			if 1.2 <= arg_286_1.time_ and arg_286_1.time_ < 1.2 + var_289_14 then
				var_289_13.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 1.2) / var_289_14)
				var_289_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_13.position).x, (manager.ui.mainCamera.transform.position - var_289_13.position).y, (manager.ui.mainCamera.transform.position - var_289_13.position).z)
				var_289_13.localEulerAngles.z = 0
				var_289_13.localEulerAngles.x = 0
				var_289_13.localEulerAngles = var_289_13.localEulerAngles
			end

			if arg_286_1.time_ >= 1.2 + var_289_14 and arg_286_1.time_ < 1.2 + var_289_14 + arg_289_0 then
				var_289_13.localPosition = Vector3.New(0, 100, 0)
				var_289_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_13.position).x, (manager.ui.mainCamera.transform.position - var_289_13.position).y, (manager.ui.mainCamera.transform.position - var_289_13.position).z)
				var_289_13.localEulerAngles.z = 0
				var_289_13.localEulerAngles.x = 0
				var_289_13.localEulerAngles = var_289_13.localEulerAngles
			end

			if 1 < arg_286_1.time_ and arg_286_1.time_ <= 1 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_16 = 2.56666666666667
			local var_289_17 = 0.075

			if 2.56666666666667 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_18 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_18:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_19 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(304021072).content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_21 = 3 <= 0 and var_289_17 or var_289_17 * (utf8.len(var_289_19) / 3)

				if (3 <= 0 and var_289_17 or var_289_17 * (utf8.len(var_289_19) / 3)) > 0 and var_289_17 < var_289_21 then
					arg_286_1.talkMaxDuration = var_289_21
					var_289_16 = var_289_16 + 0.3

					if var_289_21 + var_289_16 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_21 + var_289_16
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_22 = var_289_16 + 0.3
			local var_289_23 = math.max(var_289_17, arg_286_1.talkMaxDuration)

			if var_289_16 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_22 + var_289_23 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_22) / var_289_23

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_22 + var_289_23 and arg_286_1.time_ < var_289_22 + var_289_23 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play304021073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 304021073
		arg_292_1.duration_ = 6.77

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play304021074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if arg_292_1.bgs_.D02a == nil then
				local var_295_0 = Object.Instantiate(arg_292_1.paintGo_)

				var_295_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_295_0.name = "D02a"
				var_295_0.transform.parent = arg_292_1.stage_.transform
				var_295_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.bgs_.D02a = var_295_0
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				local var_295_1 = arg_292_1.bgs_.D02a

				arg_292_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_295_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_295_2 = var_295_1:GetComponent("SpriteRenderer")

				if var_295_2 and var_295_2.sprite then
					local var_295_3 = 2 * (var_295_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_295_1.transform.localScale = Vector3.New(var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, 0)
				end

				for iter_295_0, iter_295_1 in pairs(arg_292_1.bgs_) do
					if iter_295_0 ~= "D02a" then
						iter_295_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_295_4 = 0

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.allBtn_.enabled = false
			end

			if arg_292_1.time_ >= var_295_4 + 0.3 and arg_292_1.time_ < var_295_4 + 0.3 + arg_295_0 then
				arg_292_1.allBtn_.enabled = true
			end

			local var_295_5 = 0

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_6 = 2

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_6 then
				local var_295_7 = Color.New(0, 0, 0)

				var_295_7.a = Mathf.Lerp(1, 0, (arg_292_1.time_ - var_295_5) / var_295_6)
				arg_292_1.mask_.color = var_295_7
			end

			if arg_292_1.time_ >= var_295_5 + var_295_6 and arg_292_1.time_ < var_295_5 + var_295_6 + arg_295_0 then
				local var_295_8 = Color.New(0, 0, 0)

				arg_292_1.mask_.enabled = false
				var_295_8.a = 0
				arg_292_1.mask_.color = var_295_8
			end

			if 1 < arg_292_1.time_ and arg_292_1.time_ <= 1 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_147", "se_story_147_light_button_off", "")
			end

			if 1.2 < arg_292_1.time_ and arg_292_1.time_ <= 1.2 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.2 < arg_292_1.time_ and arg_292_1.time_ <= 0.2 + arg_295_0 then
				arg_292_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_12 = 1.774999999999
			local var_295_13 = 0.225

			if 1.774999999999 < arg_292_1.time_ and arg_292_1.time_ <= var_295_12 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_14 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_14:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_15 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(304021073).content)

				arg_292_1.text_.text = var_295_15

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_17 = 9 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_15) / 9)

				if (9 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_15) / 9)) > 0 and var_295_13 < var_295_17 then
					arg_292_1.talkMaxDuration = var_295_17
					var_295_12 = var_295_12 + 0.3

					if var_295_17 + var_295_12 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_17 + var_295_12
					end
				end

				arg_292_1.text_.text = var_295_15
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_18 = var_295_12 + 0.3
			local var_295_19 = math.max(var_295_13, arg_292_1.talkMaxDuration)

			if var_295_12 + 0.3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_18 + var_295_19 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_18) / var_295_19

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_18 + var_295_19 and arg_292_1.time_ < var_295_18 + var_295_19 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play304021074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 304021074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play304021075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 1.825

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(304021074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 73 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 73)

				if (73 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 73)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play304021075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 304021075
		arg_302_1.duration_ = 4.73

		local var_302_0 = {
			zh = 4.733,
			ja = 1.999999999999
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play304021076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1037ui_story = arg_302_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).z)
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles = arg_302_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_302_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1037ui_story"].transform.position).z)
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1037ui_story"].transform.localEulerAngles = arg_302_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1037ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1037ui_story == nil then
				arg_302_1.var_.characterEffect1037ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1037ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1037ui_story then
				arg_302_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_4 = 0
			local var_305_5 = 0.5

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(304021075)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 20 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 20)

				if (20 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 20)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021075", "story_v_out_304021.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021075", "story_v_out_304021.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_out_304021", "304021075", "story_v_out_304021.awb")

						arg_302_1:RecordAudio("304021075", var_305_11)
						arg_302_1:RecordAudio("304021075", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_304021", "304021075", "story_v_out_304021.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_304021", "304021075", "story_v_out_304021.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play304021076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 304021076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play304021077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1037ui_story"]) and arg_306_1.var_.characterEffect1037ui_story == nil then
				arg_306_1.var_.characterEffect1037ui_story = arg_306_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1037ui_story"]) then
				if arg_306_1.var_.characterEffect1037ui_story and not isNil(arg_306_1.actors_["1037ui_story"]) then
					arg_306_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1037ui_story"]) and arg_306_1.var_.characterEffect1037ui_story then
				arg_306_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.55

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(304021076).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 22 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 22)

				if (22 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 22)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play304021077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 304021077
		arg_310_1.duration_ = 3.23

		local var_310_0 = {
			zh = 3.233,
			ja = 1.999999999999
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
				arg_310_0:Play304021078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) and arg_310_1.var_.characterEffect1037ui_story == nil then
				arg_310_1.var_.characterEffect1037ui_story = arg_310_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) then
				if arg_310_1.var_.characterEffect1037ui_story and not isNil(arg_310_1.actors_["1037ui_story"]) then
					arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) and arg_310_1.var_.characterEffect1037ui_story then
				arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_313_2 = 0
			local var_313_3 = 0.425

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(304021077)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 17 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 17)

				if (17 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 17)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021077", "story_v_out_304021.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021077", "story_v_out_304021.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_out_304021", "304021077", "story_v_out_304021.awb")

						arg_310_1:RecordAudio("304021077", var_313_9)
						arg_310_1:RecordAudio("304021077", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_304021", "304021077", "story_v_out_304021.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_304021", "304021077", "story_v_out_304021.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play304021078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 304021078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play304021079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1037ui_story"]) and arg_314_1.var_.characterEffect1037ui_story == nil then
				arg_314_1.var_.characterEffect1037ui_story = arg_314_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1037ui_story"]) then
				if arg_314_1.var_.characterEffect1037ui_story and not isNil(arg_314_1.actors_["1037ui_story"]) then
					arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_0)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1037ui_story"]) and arg_314_1.var_.characterEffect1037ui_story then
				arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_317_1 = 0
			local var_317_2 = 0.6

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(304021078).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 24 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 24)

				if (24 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 24)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play304021079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 304021079
		arg_318_1.duration_ = 1.7

		local var_318_0 = {
			zh = 1.7,
			ja = 1.333
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
				arg_318_0:Play304021080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1037ui_story"]) and arg_318_1.var_.characterEffect1037ui_story == nil then
				arg_318_1.var_.characterEffect1037ui_story = arg_318_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1037ui_story"]) then
				if arg_318_1.var_.characterEffect1037ui_story and not isNil(arg_318_1.actors_["1037ui_story"]) then
					arg_318_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1037ui_story"]) and arg_318_1.var_.characterEffect1037ui_story then
				arg_318_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_321_2 = 0
			local var_321_3 = 0.05

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_4 = arg_318_1:GetWordFromCfg(304021079)
				local var_321_5 = arg_318_1:FormatText(var_321_4.content)

				arg_318_1.text_.text = var_321_5

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 2 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 2)

				if (2 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 2)) > 0 and var_321_3 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_5
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021079", "story_v_out_304021.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021079", "story_v_out_304021.awb") / 1000

					if var_321_8 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_2
					end

					if var_321_4.prefab_name ~= "" and arg_318_1.actors_[var_321_4.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_4.prefab_name].transform, "story_v_out_304021", "304021079", "story_v_out_304021.awb")

						arg_318_1:RecordAudio("304021079", var_321_9)
						arg_318_1:RecordAudio("304021079", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_304021", "304021079", "story_v_out_304021.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_304021", "304021079", "story_v_out_304021.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_10 and arg_318_1.time_ < var_321_2 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play304021080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 304021080
		arg_322_1.duration_ = 5.3

		local var_322_0 = {
			zh = 5.3,
			ja = 1.999999999999
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
				arg_322_0:Play304021081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_325_0 = 0
			local var_325_1 = 0.575

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(304021080)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 23 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 23)

				if (23 <= 0 and var_325_1 or var_325_1 * (utf8.len(var_325_3) / 23)) > 0 and var_325_1 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021080", "story_v_out_304021.awb") ~= 0 then
					local var_325_6 = manager.audio:GetVoiceLength("story_v_out_304021", "304021080", "story_v_out_304021.awb") / 1000

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end

					if var_325_2.prefab_name ~= "" and arg_322_1.actors_[var_325_2.prefab_name] ~= nil then
						local var_325_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_2.prefab_name].transform, "story_v_out_304021", "304021080", "story_v_out_304021.awb")

						arg_322_1:RecordAudio("304021080", var_325_7)
						arg_322_1:RecordAudio("304021080", var_325_7)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_304021", "304021080", "story_v_out_304021.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_304021", "304021080", "story_v_out_304021.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play304021081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 304021081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play304021082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1037ui_story"]) and arg_326_1.var_.characterEffect1037ui_story == nil then
				arg_326_1.var_.characterEffect1037ui_story = arg_326_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1037ui_story"]) then
				if arg_326_1.var_.characterEffect1037ui_story and not isNil(arg_326_1.actors_["1037ui_story"]) then
					arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_0)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1037ui_story"]) and arg_326_1.var_.characterEffect1037ui_story then
				arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_329_1 = 0
			local var_329_2 = 0.175

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(304021081).content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 7 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 7)

				if (7 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 7)) > 0 and var_329_2 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_1 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_1
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_6 = math.max(var_329_2, arg_326_1.talkMaxDuration)

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_6 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_1) / var_329_6

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_1 + var_329_6 and arg_326_1.time_ < var_329_1 + var_329_6 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play304021082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 304021082
		arg_330_1.duration_ = 9.83

		local var_330_0 = {
			zh = 9.833,
			ja = 1.999999999999
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play304021083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1037ui_story"]) and arg_330_1.var_.characterEffect1037ui_story == nil then
				arg_330_1.var_.characterEffect1037ui_story = arg_330_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1037ui_story"]) then
				if arg_330_1.var_.characterEffect1037ui_story and not isNil(arg_330_1.actors_["1037ui_story"]) then
					arg_330_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1037ui_story"]) and arg_330_1.var_.characterEffect1037ui_story then
				arg_330_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			local var_333_2 = 0
			local var_333_3 = 1.15

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_2 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_4 = arg_330_1:GetWordFromCfg(304021082)
				local var_333_5 = arg_330_1:FormatText(var_333_4.content)

				arg_330_1.text_.text = var_333_5

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_7 = 46 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 46)

				if (46 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 46)) > 0 and var_333_3 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_2
					end
				end

				arg_330_1.text_.text = var_333_5
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021082", "story_v_out_304021.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021082", "story_v_out_304021.awb") / 1000

					if var_333_8 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_2
					end

					if var_333_4.prefab_name ~= "" and arg_330_1.actors_[var_333_4.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_4.prefab_name].transform, "story_v_out_304021", "304021082", "story_v_out_304021.awb")

						arg_330_1:RecordAudio("304021082", var_333_9)
						arg_330_1:RecordAudio("304021082", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_304021", "304021082", "story_v_out_304021.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_304021", "304021082", "story_v_out_304021.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_3, arg_330_1.talkMaxDuration)

			if var_333_2 <= arg_330_1.time_ and arg_330_1.time_ < var_333_2 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_2) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_2 + var_333_10 and arg_330_1.time_ < var_333_2 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play304021083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 304021083
		arg_334_1.duration_ = 9.53

		local var_334_0 = {
			zh = 9.533,
			ja = 1.333
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
				arg_334_0:Play304021084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 1.15

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:GetWordFromCfg(304021083)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 46 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 46)

				if (46 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 46)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021083", "story_v_out_304021.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021083", "story_v_out_304021.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_304021", "304021083", "story_v_out_304021.awb")

						arg_334_1:RecordAudio("304021083", var_337_6)
						arg_334_1:RecordAudio("304021083", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_304021", "304021083", "story_v_out_304021.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_304021", "304021083", "story_v_out_304021.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play304021084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 304021084
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play304021085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1037ui_story"]) and arg_338_1.var_.characterEffect1037ui_story == nil then
				arg_338_1.var_.characterEffect1037ui_story = arg_338_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1037ui_story"]) then
				if arg_338_1.var_.characterEffect1037ui_story and not isNil(arg_338_1.actors_["1037ui_story"]) then
					arg_338_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1037ui_story"]) and arg_338_1.var_.characterEffect1037ui_story then
				arg_338_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_341_1 = 0
			local var_341_2 = 0.075

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(304021084).content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 3 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 3)

				if (3 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 3)) > 0 and var_341_2 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_6 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_6 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_6

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_6 and arg_338_1.time_ < var_341_1 + var_341_6 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play304021085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 304021085
		arg_342_1.duration_ = 1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"

			SetActive(arg_342_1.choicesGo_, true)

			for iter_343_0, iter_343_1 in ipairs(arg_342_1.choices_) do
				SetActive(iter_343_1.go, iter_343_0 <= 2)
			end

			arg_342_1.choices_[1].txt.text = arg_342_1:FormatText(StoryChoiceCfg[1762].name)
			arg_342_1.choices_[2].txt.text = arg_342_1:FormatText(StoryChoiceCfg[1763].name)
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play304021086(arg_342_1)
			end

			if arg_344_0 == 2 then
				arg_342_0:Play304021089(arg_342_1)
			end

			arg_342_1:RecordChoiceLog(304021085, 1762, 1763)
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			return
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play304021086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 304021086
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play304021087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.925

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(304021086).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 37 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 37)

				if (37 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 37)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play304021087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 304021087
		arg_350_1.duration_ = 6.53

		local var_350_0 = {
			zh = 6.533,
			ja = 1.999999999999
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play304021088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1037ui_story"]) and arg_350_1.var_.characterEffect1037ui_story == nil then
				arg_350_1.var_.characterEffect1037ui_story = arg_350_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1037ui_story"]) then
				if arg_350_1.var_.characterEffect1037ui_story and not isNil(arg_350_1.actors_["1037ui_story"]) then
					arg_350_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1037ui_story"]) and arg_350_1.var_.characterEffect1037ui_story then
				arg_350_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_2 = 0
			local var_353_3 = 0.675

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(304021087)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 27 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 27)

				if (27 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 27)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021087", "story_v_out_304021.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021087", "story_v_out_304021.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_out_304021", "304021087", "story_v_out_304021.awb")

						arg_350_1:RecordAudio("304021087", var_353_9)
						arg_350_1:RecordAudio("304021087", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_304021", "304021087", "story_v_out_304021.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_304021", "304021087", "story_v_out_304021.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_10 and arg_350_1.time_ < var_353_2 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play304021088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 304021088
		arg_354_1.duration_ = 5.8

		local var_354_0 = {
			zh = 5.8,
			ja = 1.333
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
				arg_354_0:Play304021093(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.55

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:GetWordFromCfg(304021088)
				local var_357_2 = arg_354_1:FormatText(var_357_1.content)

				arg_354_1.text_.text = var_357_2

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 22 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 22)

				if (22 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 22)) > 0 and var_357_0 < var_357_4 then
					arg_354_1.talkMaxDuration = var_357_4

					if var_357_4 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_4 + 0
					end
				end

				arg_354_1.text_.text = var_357_2
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021088", "story_v_out_304021.awb") ~= 0 then
					local var_357_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021088", "story_v_out_304021.awb") / 1000

					if var_357_5 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + 0
					end

					if var_357_1.prefab_name ~= "" and arg_354_1.actors_[var_357_1.prefab_name] ~= nil then
						local var_357_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_1.prefab_name].transform, "story_v_out_304021", "304021088", "story_v_out_304021.awb")

						arg_354_1:RecordAudio("304021088", var_357_6)
						arg_354_1:RecordAudio("304021088", var_357_6)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_304021", "304021088", "story_v_out_304021.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_304021", "304021088", "story_v_out_304021.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play304021093 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 304021093
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play304021094(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1037ui_story = arg_358_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).z)
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles = arg_358_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1037ui_story"].transform.position).z)
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1037ui_story"].transform.localEulerAngles = arg_358_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["1037ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1037ui_story == nil then
				arg_358_1.var_.characterEffect1037ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect1037ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_2)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect1037ui_story then
				arg_358_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_361_3 = 0
			local var_361_4 = 1.05

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_3 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_5 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(304021093).content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 42 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 42)

				if (42 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 42)) > 0 and var_361_4 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_3 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_3
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_4, arg_358_1.talkMaxDuration)

			if var_361_3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_3 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_3) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_3 + var_361_8 and arg_358_1.time_ < var_361_3 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304021094 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 304021094
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play304021095(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.175

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(304021094).content)

				arg_362_1.text_.text = var_365_1

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_3 = 7 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 7)

				if (7 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 7)) > 0 and var_365_0 < var_365_3 then
					arg_362_1.talkMaxDuration = var_365_3

					if var_365_3 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_3 + 0
					end
				end

				arg_362_1.text_.text = var_365_1
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_4 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_4

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play304021095 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 304021095
		arg_366_1.duration_ = 2.27

		local var_366_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play304021096(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1037ui_story = arg_366_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_369_0 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 then
				arg_366_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_366_1.time_ - 0) / var_369_0)
				arg_366_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).z)
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles = arg_366_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 then
				arg_366_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_366_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["1037ui_story"].transform.position).z)
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["1037ui_story"].transform.localEulerAngles = arg_366_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_369_1 = arg_366_1.actors_["1037ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1037ui_story == nil then
				arg_366_1.var_.characterEffect1037ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect1037ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect1037ui_story then
				arg_366_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_369_4 = 0
			local var_369_5 = 0.125

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_6 = arg_366_1:GetWordFromCfg(304021095)
				local var_369_7 = arg_366_1:FormatText(var_369_6.content)

				arg_366_1.text_.text = var_369_7

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_9 = 5 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 5)

				if (5 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 5)) > 0 and var_369_5 < var_369_9 then
					arg_366_1.talkMaxDuration = var_369_9

					if var_369_9 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_4
					end
				end

				arg_366_1.text_.text = var_369_7
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021095", "story_v_out_304021.awb") ~= 0 then
					local var_369_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021095", "story_v_out_304021.awb") / 1000

					if var_369_10 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_10 + var_369_4
					end

					if var_369_6.prefab_name ~= "" and arg_366_1.actors_[var_369_6.prefab_name] ~= nil then
						local var_369_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_6.prefab_name].transform, "story_v_out_304021", "304021095", "story_v_out_304021.awb")

						arg_366_1:RecordAudio("304021095", var_369_11)
						arg_366_1:RecordAudio("304021095", var_369_11)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_304021", "304021095", "story_v_out_304021.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_304021", "304021095", "story_v_out_304021.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_12 = math.max(var_369_5, arg_366_1.talkMaxDuration)

			if var_369_4 <= arg_366_1.time_ and arg_366_1.time_ < var_369_4 + var_369_12 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_4) / var_369_12

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_4 + var_369_12 and arg_366_1.time_ < var_369_4 + var_369_12 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play304021096 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 304021096
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play304021097(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1037ui_story"]) and arg_370_1.var_.characterEffect1037ui_story == nil then
				arg_370_1.var_.characterEffect1037ui_story = arg_370_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1037ui_story"]) then
				if arg_370_1.var_.characterEffect1037ui_story and not isNil(arg_370_1.actors_["1037ui_story"]) then
					arg_370_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1037ui_story"]) and arg_370_1.var_.characterEffect1037ui_story then
				arg_370_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.775

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(304021096).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 31 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 31)

				if (31 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 31)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play304021097 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 304021097
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play304021098(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.775

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(304021097).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 31 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 31)

				if (31 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 31)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play304021098 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 304021098
		arg_378_1.duration_ = 8

		local var_378_0 = {
			zh = 8,
			ja = 1.333
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play304021099(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1037ui_story"]) and arg_378_1.var_.characterEffect1037ui_story == nil then
				arg_378_1.var_.characterEffect1037ui_story = arg_378_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1037ui_story"]) then
				if arg_378_1.var_.characterEffect1037ui_story and not isNil(arg_378_1.actors_["1037ui_story"]) then
					arg_378_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1037ui_story"]) and arg_378_1.var_.characterEffect1037ui_story then
				arg_378_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_381_2 = 0
			local var_381_3 = 0.925

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(304021098)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 37 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 37)

				if (37 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 37)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021098", "story_v_out_304021.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021098", "story_v_out_304021.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_out_304021", "304021098", "story_v_out_304021.awb")

						arg_378_1:RecordAudio("304021098", var_381_9)
						arg_378_1:RecordAudio("304021098", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_304021", "304021098", "story_v_out_304021.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_304021", "304021098", "story_v_out_304021.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play304021099 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 304021099
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play304021100(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1037ui_story"]) and arg_382_1.var_.characterEffect1037ui_story == nil then
				arg_382_1.var_.characterEffect1037ui_story = arg_382_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1037ui_story"]) then
				if arg_382_1.var_.characterEffect1037ui_story and not isNil(arg_382_1.actors_["1037ui_story"]) then
					arg_382_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1037ui_story"]) and arg_382_1.var_.characterEffect1037ui_story then
				arg_382_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.55

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(304021099).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 22 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 22)

				if (22 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 22)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play304021100 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 304021100
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play304021101(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.95

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(304021100).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 38 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 38)

				if (38 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 38)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play304021101 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 304021101
		arg_390_1.duration_ = 3.73

		local var_390_0 = {
			zh = 3.733,
			ja = 1.999999999999
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play304021102(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1037ui_story"]) and arg_390_1.var_.characterEffect1037ui_story == nil then
				arg_390_1.var_.characterEffect1037ui_story = arg_390_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1037ui_story"]) then
				if arg_390_1.var_.characterEffect1037ui_story and not isNil(arg_390_1.actors_["1037ui_story"]) then
					arg_390_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1037ui_story"]) and arg_390_1.var_.characterEffect1037ui_story then
				arg_390_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_393_2 = 0
			local var_393_3 = 0.375

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(304021101)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 15 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 15)

				if (15 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 15)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021101", "story_v_out_304021.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021101", "story_v_out_304021.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_out_304021", "304021101", "story_v_out_304021.awb")

						arg_390_1:RecordAudio("304021101", var_393_9)
						arg_390_1:RecordAudio("304021101", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_304021", "304021101", "story_v_out_304021.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_304021", "304021101", "story_v_out_304021.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play304021102 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 304021102
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play304021103(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1037ui_story"]) and arg_394_1.var_.characterEffect1037ui_story == nil then
				arg_394_1.var_.characterEffect1037ui_story = arg_394_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1037ui_story"]) then
				if arg_394_1.var_.characterEffect1037ui_story and not isNil(arg_394_1.actors_["1037ui_story"]) then
					arg_394_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1037ui_story"]) and arg_394_1.var_.characterEffect1037ui_story then
				arg_394_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_397_1 = 0
			local var_397_2 = 0.35

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(304021102).content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 14 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 14)

				if (14 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 14)) > 0 and var_397_2 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_6 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_6 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_6

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_6 and arg_394_1.time_ < var_397_1 + var_397_6 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play304021103 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 304021103
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play304021104(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1037ui_story = arg_398_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).z)
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles = arg_398_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_398_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1037ui_story"].transform.position).z)
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1037ui_story"].transform.localEulerAngles = arg_398_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_401_1 = 0
			local var_401_2 = 0.575

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(304021103).content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 23 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 23)

				if (23 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 23)) > 0 and var_401_2 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_6 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_6 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_6

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_6 and arg_398_1.time_ < var_401_1 + var_401_6 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play304021104 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 304021104
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play304021105(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.45

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(304021104).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 18 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 18)

				if (18 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 18)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play304021105 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 304021105
		arg_406_1.duration_ = 3.7

		local var_406_0 = {
			zh = 3.7,
			ja = 1.633
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
				arg_406_0:Play304021106(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.45

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(304021105)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 18 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 18)

				if (18 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 18)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021105", "story_v_out_304021.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021105", "story_v_out_304021.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_304021", "304021105", "story_v_out_304021.awb")

						arg_406_1:RecordAudio("304021105", var_409_6)
						arg_406_1:RecordAudio("304021105", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_304021", "304021105", "story_v_out_304021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_304021", "304021105", "story_v_out_304021.awb")
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
	Play304021106 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 304021106
		arg_410_1.duration_ = 6.43

		local var_410_0 = {
			zh = 4.866,
			ja = 6.433
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
			arg_410_1.auto_ = false
		end

		function arg_410_1.playNext_(arg_412_0)
			arg_410_1.onStoryFinished_()
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.525

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:GetWordFromCfg(304021106)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 21 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 21)

				if (21 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 21)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021106", "story_v_out_304021.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021106", "story_v_out_304021.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_304021", "304021106", "story_v_out_304021.awb")

						arg_410_1:RecordAudio("304021106", var_413_6)
						arg_410_1:RecordAudio("304021106", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_304021", "304021106", "story_v_out_304021.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_304021", "304021106", "story_v_out_304021.awb")
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
	Play304021089 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 304021089
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play304021090(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.975

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(304021089).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 39 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 39)

				if (39 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 39)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play304021090 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 304021090
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play304021091(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.925

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(304021090).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 37 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 37)

				if (37 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 37)) > 0 and var_421_0 < var_421_3 then
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
	Play304021091 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 304021091
		arg_422_1.duration_ = 6.13

		local var_422_0 = {
			zh = 6.133,
			ja = 1.999999999999
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play304021092(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1037ui_story"]) and arg_422_1.var_.characterEffect1037ui_story == nil then
				arg_422_1.var_.characterEffect1037ui_story = arg_422_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1037ui_story"]) then
				if arg_422_1.var_.characterEffect1037ui_story and not isNil(arg_422_1.actors_["1037ui_story"]) then
					arg_422_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1037ui_story"]) and arg_422_1.var_.characterEffect1037ui_story then
				arg_422_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			local var_425_2 = 0
			local var_425_3 = 0.7

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(304021091)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 27 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 27)

				if (27 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 27)) > 0 and var_425_3 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021091", "story_v_out_304021.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021091", "story_v_out_304021.awb") / 1000

					if var_425_8 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_2
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_out_304021", "304021091", "story_v_out_304021.awb")

						arg_422_1:RecordAudio("304021091", var_425_9)
						arg_422_1:RecordAudio("304021091", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_304021", "304021091", "story_v_out_304021.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_304021", "304021091", "story_v_out_304021.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_10 and arg_422_1.time_ < var_425_2 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play304021092 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 304021092
		arg_426_1.duration_ = 4.87

		local var_426_0 = {
			zh = 4.866,
			ja = 1.333
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
				arg_426_0:Play304021093(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.575

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:GetWordFromCfg(304021092)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 23 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 23)

				if (23 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 23)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021092", "story_v_out_304021.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021092", "story_v_out_304021.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_304021", "304021092", "story_v_out_304021.awb")

						arg_426_1:RecordAudio("304021092", var_429_6)
						arg_426_1:RecordAudio("304021092", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_304021", "304021092", "story_v_out_304021.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_304021", "304021092", "story_v_out_304021.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play304021022 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 304021022
		arg_430_1.duration_ = 4.23

		local var_430_0 = {
			zh = 4.233,
			ja = 2.433
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
				arg_430_0:Play304021023(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1011ui_story"]) and arg_430_1.var_.characterEffect1011ui_story == nil then
				arg_430_1.var_.characterEffect1011ui_story = arg_430_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1011ui_story"]) then
				if arg_430_1.var_.characterEffect1011ui_story and not isNil(arg_430_1.actors_["1011ui_story"]) then
					arg_430_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1011ui_story"]) and arg_430_1.var_.characterEffect1011ui_story then
				arg_430_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_433_2 = arg_430_1.actors_["1019ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.characterEffect1019ui_story == nil then
				arg_430_1.var_.characterEffect1019ui_story = var_433_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_3 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.characterEffect1019ui_story and not isNil(var_433_2) then
					arg_430_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_3)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.characterEffect1019ui_story then
				arg_430_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_433_4 = 0
			local var_433_5 = 0.375

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(304021022)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 15 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 15)

				if (15 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 15)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021022", "story_v_out_304021.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021022", "story_v_out_304021.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_out_304021", "304021022", "story_v_out_304021.awb")

						arg_430_1:RecordAudio("304021022", var_433_11)
						arg_430_1:RecordAudio("304021022", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_304021", "304021022", "story_v_out_304021.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_304021", "304021022", "story_v_out_304021.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play304021023 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 304021023
		arg_434_1.duration_ = 8.5

		local var_434_0 = {
			zh = 8.4,
			ja = 8.5
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play304021024(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.95

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_1 = arg_434_1:GetWordFromCfg(304021023)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 38 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 38)

				if (38 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 38)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021023", "story_v_out_304021.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_304021", "304021023", "story_v_out_304021.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_304021", "304021023", "story_v_out_304021.awb")

						arg_434_1:RecordAudio("304021023", var_437_6)
						arg_434_1:RecordAudio("304021023", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_304021", "304021023", "story_v_out_304021.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_304021", "304021023", "story_v_out_304021.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0101",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_304021.awb"
	}
}
