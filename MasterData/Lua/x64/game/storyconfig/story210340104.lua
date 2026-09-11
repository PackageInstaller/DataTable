return {
	Play1103404001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103404001
		arg_1_1.duration_ = 3.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103404002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11p == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11p")
				var_4_0.name = "I11p"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11p = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11p

				arg_1_1.bgs_.I11p.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11p" then
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

			local var_4_9 = "1034ui_story"

			if arg_1_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1034ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, 100, 0)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1034ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_1_1.time_ - 1.8) / var_4_16)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -0.93, -6)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			local var_4_17 = arg_1_1.actors_["1034ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1034ui_story == nil then
				arg_1_1.var_.characterEffect1034ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1034ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1034ui_story then
				arg_1_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			local var_4_27 = 2
			local var_4_28 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(1103404001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)

				if (10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")

						arg_1_1:RecordAudio("1103404001", var_4_35)
						arg_1_1:RecordAudio("1103404001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103404002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103404002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103404003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1034ui_story"]) and arg_9_1.var_.characterEffect1034ui_story == nil then
				arg_9_1.var_.characterEffect1034ui_story = arg_9_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1034ui_story"]) then
				if arg_9_1.var_.characterEffect1034ui_story and not isNil(arg_9_1.actors_["1034ui_story"]) then
					arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1034ui_story"]) and arg_9_1.var_.characterEffect1034ui_story then
				arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.65

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1103404002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 66 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 66)

				if (66 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 66)) > 0 and var_12_2 < var_12_5 then
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

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1103404003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103404003
		arg_13_1.duration_ = 6.13

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103404004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.55

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[690].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(1103404003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 22 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 22)

				if (22 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 22)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")

						arg_13_1:RecordAudio("1103404003", var_16_6)
						arg_13_1:RecordAudio("1103404003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")
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
	Play1103404004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103404004
		arg_17_1.duration_ = 2.4

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1103404005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1034ui_story = arg_17_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).z)
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles = arg_17_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_17_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1034ui_story"].transform.position).z)
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1034ui_story"].transform.localEulerAngles = arg_17_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1034ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1034ui_story == nil then
				arg_17_1.var_.characterEffect1034ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1034ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1034ui_story then
				arg_17_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.325

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(1103404004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 13 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 13)

				if (13 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 13)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")

						arg_17_1:RecordAudio("1103404004", var_20_11)
						arg_17_1:RecordAudio("1103404004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")
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
				actorName = "1034ui_story",
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
	Play1103404005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103404005
		arg_21_1.duration_ = 5.93

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103404006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1034ui_story"]) and arg_21_1.var_.characterEffect1034ui_story == nil then
				arg_21_1.var_.characterEffect1034ui_story = arg_21_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1034ui_story"]) then
				if arg_21_1.var_.characterEffect1034ui_story and not isNil(arg_21_1.actors_["1034ui_story"]) then
					arg_21_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1034ui_story"]) and arg_21_1.var_.characterEffect1034ui_story then
				arg_21_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_24_1 = 0
			local var_24_2 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[690].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(1103404005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 26 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 26)

				if (26 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 26)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")

						arg_21_1:RecordAudio("1103404005", var_24_8)
						arg_21_1:RecordAudio("1103404005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")
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
	Play1103404006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1103404006
		arg_25_1.duration_ = 5.43

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1103404007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1034ui_story = arg_25_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).z)
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles = arg_25_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_25_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1034ui_story"].transform.position).z)
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1034ui_story"].transform.localEulerAngles = arg_25_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1034ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1034ui_story == nil then
				arg_25_1.var_.characterEffect1034ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1034ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1034ui_story then
				arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_28_4 = 0
			local var_28_5 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(1103404006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)

				if (28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")

						arg_25_1:RecordAudio("1103404006", var_28_11)
						arg_25_1:RecordAudio("1103404006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")
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

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103404007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1103404007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1103404008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story == nil then
				arg_29_1.var_.characterEffect1034ui_story = arg_29_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) then
				if arg_29_1.var_.characterEffect1034ui_story and not isNil(arg_29_1.actors_["1034ui_story"]) then
					arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story then
				arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_1 = 0
			local var_32_2 = 1.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1103404007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 46 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 46)

				if (46 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 46)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1103404008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1103404008
		arg_33_1.duration_ = 3.27

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1103404009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = arg_33_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) then
				if arg_33_1.var_.characterEffect1034ui_story and not isNil(arg_33_1.actors_["1034ui_story"]) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 0.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1103404008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 16 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 16)

				if (16 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 16)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")

						arg_33_1:RecordAudio("1103404008", var_36_9)
						arg_33_1:RecordAudio("1103404008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")
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
	Play1103404009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1103404009
		arg_37_1.duration_ = 7.13

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1103404010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) and arg_37_1.var_.characterEffect1034ui_story == nil then
				arg_37_1.var_.characterEffect1034ui_story = arg_37_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) then
				if arg_37_1.var_.characterEffect1034ui_story and not isNil(arg_37_1.actors_["1034ui_story"]) then
					arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) and arg_37_1.var_.characterEffect1034ui_story then
				arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[690].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1103404009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 26)

				if (26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 26)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")

						arg_37_1:RecordAudio("1103404009", var_40_8)
						arg_37_1:RecordAudio("1103404009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")
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
	Play1103404010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1103404010
		arg_41_1.duration_ = 5.57

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1103404011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story == nil then
				arg_41_1.var_.characterEffect1034ui_story = arg_41_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) then
				if arg_41_1.var_.characterEffect1034ui_story and not isNil(arg_41_1.actors_["1034ui_story"]) then
					arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story then
				arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_44_2 = 0
			local var_44_3 = 0.7

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(1103404010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)

				if (28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")

						arg_41_1:RecordAudio("1103404010", var_44_9)
						arg_41_1:RecordAudio("1103404010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1103404011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1103404011
		arg_45_1.duration_ = 5.83

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1103404012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(1103404011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 31 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 31)

				if (31 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 31)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")

						arg_45_1:RecordAudio("1103404011", var_48_6)
						arg_45_1:RecordAudio("1103404011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")
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
	Play1103404012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1103404012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1103404013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_52_0 = 0
			local var_52_1 = 0.1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(1103404012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 4 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 4)

				if (4 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 4)) > 0 and var_52_1 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb") ~= 0 then
					local var_52_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb") / 1000

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end

					if var_52_2.prefab_name ~= "" and arg_49_1.actors_[var_52_2.prefab_name] ~= nil then
						local var_52_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_2.prefab_name].transform, "story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")

						arg_49_1:RecordAudio("1103404012", var_52_7)
						arg_49_1:RecordAudio("1103404012", var_52_7)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1103404013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1103404013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1103404014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) and arg_53_1.var_.characterEffect1034ui_story == nil then
				arg_53_1.var_.characterEffect1034ui_story = arg_53_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) then
				if arg_53_1.var_.characterEffect1034ui_story and not isNil(arg_53_1.actors_["1034ui_story"]) then
					arg_53_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) and arg_53_1.var_.characterEffect1034ui_story then
				arg_53_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 1.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1103404013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 49 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 49)

				if (49 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 49)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1103404014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1103404014
		arg_57_1.duration_ = 2

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1103404015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story == nil then
				arg_57_1.var_.characterEffect1034ui_story = arg_57_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) then
				if arg_57_1.var_.characterEffect1034ui_story and not isNil(arg_57_1.actors_["1034ui_story"]) then
					arg_57_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story then
				arg_57_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_60_2 = 0
			local var_60_3 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1103404014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 10 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 10)

				if (10 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 10)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")

						arg_57_1:RecordAudio("1103404014", var_60_9)
						arg_57_1:RecordAudio("1103404014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1103404015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1103404015
		arg_61_1.duration_ = 4.9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1103404016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) and arg_61_1.var_.characterEffect1034ui_story == nil then
				arg_61_1.var_.characterEffect1034ui_story = arg_61_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) then
				if arg_61_1.var_.characterEffect1034ui_story and not isNil(arg_61_1.actors_["1034ui_story"]) then
					arg_61_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) and arg_61_1.var_.characterEffect1034ui_story then
				arg_61_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(1103404015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 16 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 16)

				if (16 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 16)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")

						arg_61_1:RecordAudio("1103404015", var_64_8)
						arg_61_1:RecordAudio("1103404015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1103404016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1103404016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1103404017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1034ui_story"]) and arg_65_1.var_.characterEffect1034ui_story == nil then
				arg_65_1.var_.characterEffect1034ui_story = arg_65_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1034ui_story"]) then
				if arg_65_1.var_.characterEffect1034ui_story and not isNil(arg_65_1.actors_["1034ui_story"]) then
					arg_65_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1034ui_story"]) and arg_65_1.var_.characterEffect1034ui_story then
				arg_65_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_68_2 = 0
			local var_68_3 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(1103404016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 5 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 5)

				if (5 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 5)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")

						arg_65_1:RecordAudio("1103404016", var_68_9)
						arg_65_1:RecordAudio("1103404016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1103404017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1103404017
		arg_69_1.duration_ = 5.27

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1103404018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) and arg_69_1.var_.characterEffect1034ui_story == nil then
				arg_69_1.var_.characterEffect1034ui_story = arg_69_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) then
				if arg_69_1.var_.characterEffect1034ui_story and not isNil(arg_69_1.actors_["1034ui_story"]) then
					arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) and arg_69_1.var_.characterEffect1034ui_story then
				arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(1103404017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 17 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 17)

				if (17 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 17)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")

						arg_69_1:RecordAudio("1103404017", var_72_8)
						arg_69_1:RecordAudio("1103404017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")
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

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1103404018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1103404018
		arg_73_1.duration_ = 7.1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1103404019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) and arg_73_1.var_.characterEffect1034ui_story == nil then
				arg_73_1.var_.characterEffect1034ui_story = arg_73_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) then
				if arg_73_1.var_.characterEffect1034ui_story and not isNil(arg_73_1.actors_["1034ui_story"]) then
					arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) and arg_73_1.var_.characterEffect1034ui_story then
				arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.75

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1103404018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 30 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 30)

				if (30 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 30)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")

						arg_73_1:RecordAudio("1103404018", var_76_9)
						arg_73_1:RecordAudio("1103404018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1103404019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1103404019
		arg_77_1.duration_ = 6.27

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1103404020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.85

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(1103404019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 34 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 34)

				if (34 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 34)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")

						arg_77_1:RecordAudio("1103404019", var_80_6)
						arg_77_1:RecordAudio("1103404019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1103404020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1103404020
		arg_81_1.duration_ = 5.67

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1103404021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) and arg_81_1.var_.characterEffect1034ui_story == nil then
				arg_81_1.var_.characterEffect1034ui_story = arg_81_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.366666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) then
				if arg_81_1.var_.characterEffect1034ui_story and not isNil(arg_81_1.actors_["1034ui_story"]) then
					arg_81_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) and arg_81_1.var_.characterEffect1034ui_story then
				arg_81_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_1 = 0
			local var_84_2 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(1103404020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 20 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 20)

				if (20 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 20)) > 0 and var_84_2 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb") ~= 0 then
					local var_84_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb") / 1000

					if var_84_7 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_1
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")

						arg_81_1:RecordAudio("1103404020", var_84_8)
						arg_81_1:RecordAudio("1103404020", var_84_8)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_9 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_9 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_9

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_9 and arg_81_1.time_ < var_84_1 + var_84_9 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1103404021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1103404021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1103404022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_88_0 = 0
			local var_88_1 = 1.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1103404021).content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 55 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 55)

				if (55 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 55)) > 0 and var_88_1 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_5 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_5 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_5

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_5 and arg_85_1.time_ < var_88_0 + var_88_5 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1103404022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1103404022
		arg_89_1.duration_ = 2.9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1103404023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0.0173333351810773 < arg_89_1.time_ and arg_89_1.time_ <= 0.0173333351810773 + arg_92_0 then
				arg_89_1.var_.moveOldPos1034ui_story = arg_89_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0.0173333351810773 <= arg_89_1.time_ and arg_89_1.time_ < 0.0173333351810773 + var_92_0 then
				arg_89_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_89_1.time_ - 0.0173333351810773) / var_92_0)
				arg_89_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).z)
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles = arg_89_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0.0173333351810773 + var_92_0 and arg_89_1.time_ < 0.0173333351810773 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_89_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1034ui_story"].transform.position).z)
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1034ui_story"].transform.localEulerAngles = arg_89_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1034ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1034ui_story == nil then
				arg_89_1.var_.characterEffect1034ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1034ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1034ui_story then
				arg_89_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(1103404022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 16 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 16)

				if (16 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 16)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")

						arg_89_1:RecordAudio("1103404022", var_92_11)
						arg_89_1:RecordAudio("1103404022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0173333351810773,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1103404023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1103404023
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1103404024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				local var_96_0 = arg_93_1.bgs_.I11p

				arg_93_1.bgs_.I11p.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_1 = var_96_0:GetComponent("SpriteRenderer")

				if var_96_1 and var_96_1.sprite then
					local var_96_2 = 2 * (var_96_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_0.transform.localScale = Vector3.New(var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "I11p" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_3 = 4

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
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

			local var_96_12 = arg_93_1.actors_["1034ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_12) and arg_93_1.var_.characterEffect1034ui_story == nil then
				arg_93_1.var_.characterEffect1034ui_story = var_96_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_13 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_13 and not isNil(var_96_12) then
				if arg_93_1.var_.characterEffect1034ui_story and not isNil(var_96_12) then
					arg_93_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_13)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_13 and arg_93_1.time_ < 0 + var_96_13 + arg_96_0 and not isNil(var_96_12) and arg_93_1.var_.characterEffect1034ui_story then
				arg_93_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_96_14 = arg_93_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_93_1.time_ and arg_93_1.time_ <= 1.98333333333333 + arg_96_0 then
				arg_93_1.var_.moveOldPos1034ui_story = var_96_14.localPosition
			end

			local var_96_15 = 0.001

			if 1.98333333333333 <= arg_93_1.time_ and arg_93_1.time_ < 1.98333333333333 + var_96_15 then
				var_96_14.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 1.98333333333333) / var_96_15)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if arg_93_1.time_ >= 1.98333333333333 + var_96_15 and arg_93_1.time_ < 1.98333333333333 + var_96_15 + arg_96_0 then
				var_96_14.localPosition = Vector3.New(0, 100, 0)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_16 = 4
			local var_96_17 = 1.475

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_18 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_18:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1103404023).content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 59 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 59)

				if (59 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 59)) > 0 and var_96_17 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21
					var_96_16 = var_96_16 + 0.3

					if var_96_21 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = var_96_16 + 0.3
			local var_96_23 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_23 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_22) / var_96_23

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_22 + var_96_23 and arg_93_1.time_ < var_96_22 + var_96_23 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1103404024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1103404024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1103404025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.275

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
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

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1103404024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 11 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 11)

				if (11 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 11)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1103404025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1103404025
		arg_103_1.duration_ = 3.8

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1103404026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1034ui_story = arg_103_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).z)
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles = arg_103_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_103_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1034ui_story"].transform.position).z)
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1034ui_story"].transform.localEulerAngles = arg_103_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1034ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1034ui_story == nil then
				arg_103_1.var_.characterEffect1034ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1034ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1034ui_story then
				arg_103_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_106_4 = 0
			local var_106_5 = 0.325

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(1103404025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)

				if (13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")

						arg_103_1:RecordAudio("1103404025", var_106_11)
						arg_103_1:RecordAudio("1103404025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103404026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1103404026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1103404027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1034ui_story"]) and arg_107_1.var_.characterEffect1034ui_story == nil then
				arg_107_1.var_.characterEffect1034ui_story = arg_107_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1034ui_story"]) then
				if arg_107_1.var_.characterEffect1034ui_story and not isNil(arg_107_1.actors_["1034ui_story"]) then
					arg_107_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1034ui_story"]) and arg_107_1.var_.characterEffect1034ui_story then
				arg_107_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.15

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1103404026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 6 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 6)

				if (6 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 6)) > 0 and var_110_2 < var_110_5 then
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
	Play1103404027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1103404027
		arg_111_1.duration_ = 7.5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1103404028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1034ui_story"]) and arg_111_1.var_.characterEffect1034ui_story == nil then
				arg_111_1.var_.characterEffect1034ui_story = arg_111_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1034ui_story"]) then
				if arg_111_1.var_.characterEffect1034ui_story and not isNil(arg_111_1.actors_["1034ui_story"]) then
					arg_111_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1034ui_story"]) and arg_111_1.var_.characterEffect1034ui_story then
				arg_111_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_114_2 = 0
			local var_114_3 = 0.9

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(1103404027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 36 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 36)

				if (36 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 36)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")

						arg_111_1:RecordAudio("1103404027", var_114_9)
						arg_111_1:RecordAudio("1103404027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")
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
	Play1103404028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1103404028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1103404029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1034ui_story"]) and arg_115_1.var_.characterEffect1034ui_story == nil then
				arg_115_1.var_.characterEffect1034ui_story = arg_115_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1034ui_story"]) then
				if arg_115_1.var_.characterEffect1034ui_story and not isNil(arg_115_1.actors_["1034ui_story"]) then
					arg_115_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1034ui_story"]) and arg_115_1.var_.characterEffect1034ui_story then
				arg_115_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.325

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

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1103404028).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 13 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 13)

				if (13 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 13)) > 0 and var_118_2 < var_118_5 then
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
	Play1103404029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1103404029
		arg_119_1.duration_ = 7.27

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1103404030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1034ui_story"]) and arg_119_1.var_.characterEffect1034ui_story == nil then
				arg_119_1.var_.characterEffect1034ui_story = arg_119_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1034ui_story"]) then
				if arg_119_1.var_.characterEffect1034ui_story and not isNil(arg_119_1.actors_["1034ui_story"]) then
					arg_119_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1034ui_story"]) and arg_119_1.var_.characterEffect1034ui_story then
				arg_119_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_122_2 = 0
			local var_122_3 = 0.825

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(1103404029)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 33 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 33)

				if (33 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 33)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")

						arg_119_1:RecordAudio("1103404029", var_122_9)
						arg_119_1:RecordAudio("1103404029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1103404030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1103404030
		arg_123_1.duration_ = 6.47

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1103404031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_126_0 = 0
			local var_126_1 = 0.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(1103404030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 29 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 29)

				if (29 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 29)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb") ~= 0 then
					local var_126_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb") / 1000

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end

					if var_126_2.prefab_name ~= "" and arg_123_1.actors_[var_126_2.prefab_name] ~= nil then
						local var_126_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_2.prefab_name].transform, "story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")

						arg_123_1:RecordAudio("1103404030", var_126_7)
						arg_123_1:RecordAudio("1103404030", var_126_7)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1103404031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1103404031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1103404032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1034ui_story"]) and arg_127_1.var_.characterEffect1034ui_story == nil then
				arg_127_1.var_.characterEffect1034ui_story = arg_127_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1034ui_story"]) then
				if arg_127_1.var_.characterEffect1034ui_story and not isNil(arg_127_1.actors_["1034ui_story"]) then
					arg_127_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1034ui_story"]) and arg_127_1.var_.characterEffect1034ui_story then
				arg_127_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.7

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
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

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1103404031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 28 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 28)

				if (28 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 28)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1103404032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1103404032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1103404033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.875

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

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1103404032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 35 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 35)

				if (35 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 35)) > 0 and var_134_0 < var_134_3 then
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
	Play1103404033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1103404033
		arg_135_1.duration_ = 6.37

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1103404034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1034ui_story"]) and arg_135_1.var_.characterEffect1034ui_story == nil then
				arg_135_1.var_.characterEffect1034ui_story = arg_135_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1034ui_story"]) then
				if arg_135_1.var_.characterEffect1034ui_story and not isNil(arg_135_1.actors_["1034ui_story"]) then
					arg_135_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1034ui_story"]) and arg_135_1.var_.characterEffect1034ui_story then
				arg_135_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_138_2 = 0
			local var_138_3 = 0.725

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(1103404033)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 29 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 29)

				if (29 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 29)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")

						arg_135_1:RecordAudio("1103404033", var_138_9)
						arg_135_1:RecordAudio("1103404033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")
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
	Play1103404034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1103404034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1103404035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1034ui_story"]) and arg_139_1.var_.characterEffect1034ui_story == nil then
				arg_139_1.var_.characterEffect1034ui_story = arg_139_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1034ui_story"]) then
				if arg_139_1.var_.characterEffect1034ui_story and not isNil(arg_139_1.actors_["1034ui_story"]) then
					arg_139_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1034ui_story"]) and arg_139_1.var_.characterEffect1034ui_story then
				arg_139_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.35

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
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

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1103404034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 14 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 14)

				if (14 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 14)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1103404035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1103404035
		arg_143_1.duration_ = 3.37

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1103404036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1034ui_story"]) and arg_143_1.var_.characterEffect1034ui_story == nil then
				arg_143_1.var_.characterEffect1034ui_story = arg_143_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1034ui_story"]) then
				if arg_143_1.var_.characterEffect1034ui_story and not isNil(arg_143_1.actors_["1034ui_story"]) then
					arg_143_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1034ui_story"]) and arg_143_1.var_.characterEffect1034ui_story then
				arg_143_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action447")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_146_2 = 0
			local var_146_3 = 0.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1103404035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 15 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 15)

				if (15 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 15)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")

						arg_143_1:RecordAudio("1103404035", var_146_9)
						arg_143_1:RecordAudio("1103404035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1103404036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1103404036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1103404037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1034ui_story"]) and arg_147_1.var_.characterEffect1034ui_story == nil then
				arg_147_1.var_.characterEffect1034ui_story = arg_147_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1034ui_story"]) then
				if arg_147_1.var_.characterEffect1034ui_story and not isNil(arg_147_1.actors_["1034ui_story"]) then
					arg_147_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1034ui_story"]) and arg_147_1.var_.characterEffect1034ui_story then
				arg_147_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.7

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1103404036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 28 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 28)

				if (28 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 28)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1103404037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1103404037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1103404038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_154_0 = 0
			local var_154_1 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_2 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1103404037).content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 21 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_2) / 21)

				if (21 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_2) / 21)) > 0 and var_154_1 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_5 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_5 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_5

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_5 and arg_151_1.time_ < var_154_0 + var_154_5 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1103404038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1103404038
		arg_155_1.duration_ = 6.27

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1103404039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1034ui_story"]) and arg_155_1.var_.characterEffect1034ui_story == nil then
				arg_155_1.var_.characterEffect1034ui_story = arg_155_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1034ui_story"]) then
				if arg_155_1.var_.characterEffect1034ui_story and not isNil(arg_155_1.actors_["1034ui_story"]) then
					arg_155_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1034ui_story"]) and arg_155_1.var_.characterEffect1034ui_story then
				arg_155_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_158_2 = 0
			local var_158_3 = 0.6

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(1103404038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 24 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 24)

				if (24 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 24)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")

						arg_155_1:RecordAudio("1103404038", var_158_9)
						arg_155_1:RecordAudio("1103404038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1103404039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1103404039
		arg_159_1.duration_ = 5.1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1103404040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426", "EmotionTimelineAnimator")
			end

			local var_162_0 = 0
			local var_162_1 = 0.675

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(1103404039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 27 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 27)

				if (27 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 27)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")

						arg_159_1:RecordAudio("1103404039", var_162_7)
						arg_159_1:RecordAudio("1103404039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1103404040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1103404040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1103404041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1034ui_story"]) and arg_163_1.var_.characterEffect1034ui_story == nil then
				arg_163_1.var_.characterEffect1034ui_story = arg_163_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1034ui_story"]) then
				if arg_163_1.var_.characterEffect1034ui_story and not isNil(arg_163_1.actors_["1034ui_story"]) then
					arg_163_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1034ui_story"]) and arg_163_1.var_.characterEffect1034ui_story then
				arg_163_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.95

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1103404040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 38 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 38)

				if (38 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 38)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1103404041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1103404041
		arg_167_1.duration_ = 6.63

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1103404042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1034ui_story"]) and arg_167_1.var_.characterEffect1034ui_story == nil then
				arg_167_1.var_.characterEffect1034ui_story = arg_167_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1034ui_story"]) then
				if arg_167_1.var_.characterEffect1034ui_story and not isNil(arg_167_1.actors_["1034ui_story"]) then
					arg_167_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1034ui_story"]) and arg_167_1.var_.characterEffect1034ui_story then
				arg_167_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_170_2 = 0
			local var_170_3 = 1.05

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(1103404041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 42 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 42)

				if (42 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 42)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")

						arg_167_1:RecordAudio("1103404041", var_170_9)
						arg_167_1:RecordAudio("1103404041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1103404042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1103404042
		arg_171_1.duration_ = 4.4

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1103404043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_174_0 = 0
			local var_174_1 = 0.475

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(1103404042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 19 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 19)

				if (19 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 19)) > 0 and var_174_1 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb") ~= 0 then
					local var_174_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb") / 1000

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end

					if var_174_2.prefab_name ~= "" and arg_171_1.actors_[var_174_2.prefab_name] ~= nil then
						local var_174_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_2.prefab_name].transform, "story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")

						arg_171_1:RecordAudio("1103404042", var_174_7)
						arg_171_1:RecordAudio("1103404042", var_174_7)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1103404043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1103404043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1103404044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1034ui_story"]) and arg_175_1.var_.characterEffect1034ui_story == nil then
				arg_175_1.var_.characterEffect1034ui_story = arg_175_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1034ui_story"]) then
				if arg_175_1.var_.characterEffect1034ui_story and not isNil(arg_175_1.actors_["1034ui_story"]) then
					arg_175_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1034ui_story"]) and arg_175_1.var_.characterEffect1034ui_story then
				arg_175_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_178_1 = 0
			local var_178_2 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1103404043).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 18 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 18)

				if (18 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 18)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1103404044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1103404044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1103404045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_0 = 0
			local var_182_1 = 1.075

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_2 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1103404044).content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 43 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_2) / 43)

				if (43 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_2) / 43)) > 0 and var_182_1 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_5 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_5 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_5

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_5 and arg_179_1.time_ < var_182_0 + var_182_5 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1103404045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1103404045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1103404046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.975

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1103404045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 39 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 39)

				if (39 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 39)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1103404046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1103404046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1103404047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_190_0 = 0
			local var_190_1 = 1.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1103404046).content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 46 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_2) / 46)

				if (46 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_2) / 46)) > 0 and var_190_1 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_5 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_5 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_5

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_5 and arg_187_1.time_ < var_190_0 + var_190_5 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1103404047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1103404047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1103404048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.15

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1103404047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 6 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 6)

				if (6 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 6)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1103404048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1103404048
		arg_195_1.duration_ = 2

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1103404049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1034ui_story"]) and arg_195_1.var_.characterEffect1034ui_story == nil then
				arg_195_1.var_.characterEffect1034ui_story = arg_195_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1034ui_story"]) then
				if arg_195_1.var_.characterEffect1034ui_story and not isNil(arg_195_1.actors_["1034ui_story"]) then
					arg_195_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1034ui_story"]) and arg_195_1.var_.characterEffect1034ui_story then
				arg_195_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2", "EmotionTimelineAnimator")
			end

			local var_198_2 = 0
			local var_198_3 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(1103404048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 4 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 4)

				if (4 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 4)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")

						arg_195_1:RecordAudio("1103404048", var_198_9)
						arg_195_1:RecordAudio("1103404048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_10 and arg_195_1.time_ < var_198_2 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1103404049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1103404049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1103404050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1034ui_story"]) and arg_199_1.var_.characterEffect1034ui_story == nil then
				arg_199_1.var_.characterEffect1034ui_story = arg_199_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1034ui_story"]) then
				if arg_199_1.var_.characterEffect1034ui_story and not isNil(arg_199_1.actors_["1034ui_story"]) then
					arg_199_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1034ui_story"]) and arg_199_1.var_.characterEffect1034ui_story then
				arg_199_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1103404049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)

				if (27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1103404050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1103404050
		arg_203_1.duration_ = 5.93

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1103404051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) and arg_203_1.var_.characterEffect1034ui_story == nil then
				arg_203_1.var_.characterEffect1034ui_story = arg_203_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) then
				if arg_203_1.var_.characterEffect1034ui_story and not isNil(arg_203_1.actors_["1034ui_story"]) then
					arg_203_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) and arg_203_1.var_.characterEffect1034ui_story then
				arg_203_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(1103404050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 26 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 26)

				if (26 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 26)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")

						arg_203_1:RecordAudio("1103404050", var_206_9)
						arg_203_1:RecordAudio("1103404050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1103404051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1103404051
		arg_207_1.duration_ = 5.7

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1103404052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_210_0 = 0
			local var_210_1 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(1103404051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 31 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 31)

				if (31 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 31)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")

						arg_207_1:RecordAudio("1103404051", var_210_7)
						arg_207_1:RecordAudio("1103404051", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1103404052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1103404052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1103404053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1034ui_story"]) and arg_211_1.var_.characterEffect1034ui_story == nil then
				arg_211_1.var_.characterEffect1034ui_story = arg_211_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1034ui_story"]) then
				if arg_211_1.var_.characterEffect1034ui_story and not isNil(arg_211_1.actors_["1034ui_story"]) then
					arg_211_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1034ui_story"]) and arg_211_1.var_.characterEffect1034ui_story then
				arg_211_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_1 = 0
			local var_214_2 = 1

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1103404052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 40 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 40)

				if (40 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 40)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1103404053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1103404053
		arg_215_1.duration_ = 15.83

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1103404054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1034ui_story"]) and arg_215_1.var_.characterEffect1034ui_story == nil then
				arg_215_1.var_.characterEffect1034ui_story = arg_215_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1034ui_story"]) then
				if arg_215_1.var_.characterEffect1034ui_story and not isNil(arg_215_1.actors_["1034ui_story"]) then
					arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1034ui_story"]) and arg_215_1.var_.characterEffect1034ui_story then
				arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_218_2 = 0
			local var_218_3 = 1.4

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(1103404053)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 56 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 56)

				if (56 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 56)) > 0 and var_218_3 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb") / 1000

					if var_218_8 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_2
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")

						arg_215_1:RecordAudio("1103404053", var_218_9)
						arg_215_1:RecordAudio("1103404053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_10 and arg_215_1.time_ < var_218_2 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1103404054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1103404054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1103404055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1034ui_story"]) and arg_219_1.var_.characterEffect1034ui_story == nil then
				arg_219_1.var_.characterEffect1034ui_story = arg_219_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1034ui_story"]) then
				if arg_219_1.var_.characterEffect1034ui_story and not isNil(arg_219_1.actors_["1034ui_story"]) then
					arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1034ui_story"]) and arg_219_1.var_.characterEffect1034ui_story then
				arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1103404054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 15 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 15)

				if (15 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 15)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1103404055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1103404055
		arg_223_1.duration_ = 2

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"

			SetActive(arg_223_1.choicesGo_, true)

			for iter_224_0, iter_224_1 in ipairs(arg_223_1.choices_) do
				SetActive(iter_224_1.go, iter_224_0 <= 3)
			end

			arg_223_1.choices_[1].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1461].name)
			arg_223_1.choices_[2].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1462].name)
			arg_223_1.choices_[3].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1463].name)
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1103404056(arg_223_1)
			end

			if arg_225_0 == 2 then
				arg_223_0:Play1103404058(arg_223_1)
			end

			if arg_225_0 == 3 then
				arg_223_0:Play1103404060(arg_223_1)
			end

			arg_223_1:RecordChoiceLog(1103404055, 1461, 1462, 1463)
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_0 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_0 + 2 and arg_223_1.time_ < var_226_0 + 2 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1103404056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1103404056
		arg_227_1.duration_ = 3.27

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1103404057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1034ui_story"]) and arg_227_1.var_.characterEffect1034ui_story == nil then
				arg_227_1.var_.characterEffect1034ui_story = arg_227_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1034ui_story"]) then
				if arg_227_1.var_.characterEffect1034ui_story and not isNil(arg_227_1.actors_["1034ui_story"]) then
					arg_227_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1034ui_story"]) and arg_227_1.var_.characterEffect1034ui_story then
				arg_227_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_2 = 0
			local var_230_3 = 0.55

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(1103404056)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 22 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 22)

				if (22 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 22)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")

						arg_227_1:RecordAudio("1103404056", var_230_9)
						arg_227_1:RecordAudio("1103404056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1103404057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1103404057
		arg_231_1.duration_ = 5.7

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1103404062(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_234_0 = 0
			local var_234_1 = 0.75

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(1103404057)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 30 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 30)

				if (30 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 30)) > 0 and var_234_1 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb") ~= 0 then
					local var_234_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb") / 1000

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end

					if var_234_2.prefab_name ~= "" and arg_231_1.actors_[var_234_2.prefab_name] ~= nil then
						local var_234_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_2.prefab_name].transform, "story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")

						arg_231_1:RecordAudio("1103404057", var_234_7)
						arg_231_1:RecordAudio("1103404057", var_234_7)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_8 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_8 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_8

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_8 and arg_231_1.time_ < var_234_0 + var_234_8 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1103404062 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1103404062
		arg_235_1.duration_ = 2.73

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1103404063(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_0 = 0
			local var_238_1 = 0.275

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(1103404062)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 11 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 11)

				if (11 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 11)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")

						arg_235_1:RecordAudio("1103404062", var_238_7)
						arg_235_1:RecordAudio("1103404062", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1103404063 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1103404063
		arg_239_1.duration_ = 4.53

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1103404064(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_242_0 = 0
			local var_242_1 = 0.65

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(1103404063)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 26 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 26)

				if (26 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 26)) > 0 and var_242_1 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb") ~= 0 then
					local var_242_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb") / 1000

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end

					if var_242_2.prefab_name ~= "" and arg_239_1.actors_[var_242_2.prefab_name] ~= nil then
						local var_242_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_2.prefab_name].transform, "story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")

						arg_239_1:RecordAudio("1103404063", var_242_7)
						arg_239_1:RecordAudio("1103404063", var_242_7)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")
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
	Play1103404064 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1103404064
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1103404065(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1034ui_story"]) and arg_243_1.var_.characterEffect1034ui_story == nil then
				arg_243_1.var_.characterEffect1034ui_story = arg_243_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1034ui_story"]) then
				if arg_243_1.var_.characterEffect1034ui_story and not isNil(arg_243_1.actors_["1034ui_story"]) then
					arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1034ui_story"]) and arg_243_1.var_.characterEffect1034ui_story then
				arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.15

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
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

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1103404064).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 6 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 6)

				if (6 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 6)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1103404065 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1103404065
		arg_247_1.duration_ = 4.4

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1103404066(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1034ui_story"]) and arg_247_1.var_.characterEffect1034ui_story == nil then
				arg_247_1.var_.characterEffect1034ui_story = arg_247_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1034ui_story"]) then
				if arg_247_1.var_.characterEffect1034ui_story and not isNil(arg_247_1.actors_["1034ui_story"]) then
					arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1034ui_story"]) and arg_247_1.var_.characterEffect1034ui_story then
				arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_2 = 0
			local var_250_3 = 0.775

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(1103404065)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 31 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 31)

				if (31 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 31)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")

						arg_247_1:RecordAudio("1103404065", var_250_9)
						arg_247_1:RecordAudio("1103404065", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1103404066 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1103404066
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1103404067(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1034ui_story"]) and arg_251_1.var_.characterEffect1034ui_story == nil then
				arg_251_1.var_.characterEffect1034ui_story = arg_251_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1034ui_story"]) then
				if arg_251_1.var_.characterEffect1034ui_story and not isNil(arg_251_1.actors_["1034ui_story"]) then
					arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1034ui_story"]) and arg_251_1.var_.characterEffect1034ui_story then
				arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.5

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1103404066).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 20 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 20)

				if (20 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 20)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1103404067 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1103404067
		arg_255_1.duration_ = 8.38

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1103404068(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 2.4 < arg_255_1.time_ and arg_255_1.time_ <= 2.4 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action474")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 2.4 < arg_255_1.time_ and arg_255_1.time_ <= 2.4 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_258_0 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			if arg_255_1.time_ >= var_258_0 + 3.375 and arg_255_1.time_ < var_258_0 + 3.375 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_1 = 3.375
			local var_258_2 = 1.025

			if 3.375 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_3 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_3:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1103404067).content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 41 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_4) / 41)

				if (41 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_4) / 41)) > 0 and var_258_2 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6
					var_258_1 = var_258_1 + 0.3

					if var_258_6 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = var_258_1 + 0.3
			local var_258_8 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_7) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1103404068 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1103404068
		arg_261_1.duration_ = 4.2

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1103404069(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1034ui_story"]) and arg_261_1.var_.characterEffect1034ui_story == nil then
				arg_261_1.var_.characterEffect1034ui_story = arg_261_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1034ui_story"]) then
				if arg_261_1.var_.characterEffect1034ui_story and not isNil(arg_261_1.actors_["1034ui_story"]) then
					arg_261_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1034ui_story"]) and arg_261_1.var_.characterEffect1034ui_story then
				arg_261_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_264_2 = 0
			local var_264_3 = 0.425

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:GetWordFromCfg(1103404068)
				local var_264_5 = arg_261_1:FormatText(var_264_4.content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 17 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 17)

				if (17 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 17)) > 0 and var_264_3 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb") / 1000

					if var_264_8 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_2
					end

					if var_264_4.prefab_name ~= "" and arg_261_1.actors_[var_264_4.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_4.prefab_name].transform, "story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")

						arg_261_1:RecordAudio("1103404068", var_264_9)
						arg_261_1:RecordAudio("1103404068", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_10 and arg_261_1.time_ < var_264_2 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1103404069 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1103404069
		arg_265_1.duration_ = 7.93

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1103404070(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_2")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_268_0 = 0
			local var_268_1 = 0.95

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(1103404069)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 37 <= 0 and var_268_1 or var_268_1 * (utf8.len(var_268_3) / 37)

				if (37 <= 0 and var_268_1 or var_268_1 * (utf8.len(var_268_3) / 37)) > 0 and var_268_1 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb") ~= 0 then
					local var_268_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb") / 1000

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end

					if var_268_2.prefab_name ~= "" and arg_265_1.actors_[var_268_2.prefab_name] ~= nil then
						local var_268_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_2.prefab_name].transform, "story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")

						arg_265_1:RecordAudio("1103404069", var_268_7)
						arg_265_1:RecordAudio("1103404069", var_268_7)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1103404070 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1103404070
		arg_269_1.duration_ = 8.67

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1103404071(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.05

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(1103404070)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 42 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 42)

				if (42 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 42)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")

						arg_269_1:RecordAudio("1103404070", var_272_6)
						arg_269_1:RecordAudio("1103404070", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1103404071 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1103404071
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1103404072(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1034ui_story"]) and arg_273_1.var_.characterEffect1034ui_story == nil then
				arg_273_1.var_.characterEffect1034ui_story = arg_273_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1034ui_story"]) then
				if arg_273_1.var_.characterEffect1034ui_story and not isNil(arg_273_1.actors_["1034ui_story"]) then
					arg_273_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1034ui_story"]) and arg_273_1.var_.characterEffect1034ui_story then
				arg_273_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.3

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1103404071).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 12 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 12)

				if (12 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 12)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1103404072 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1103404072
		arg_277_1.duration_ = 3.1

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1103404073(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1034ui_story"]) and arg_277_1.var_.characterEffect1034ui_story == nil then
				arg_277_1.var_.characterEffect1034ui_story = arg_277_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1034ui_story"]) then
				if arg_277_1.var_.characterEffect1034ui_story and not isNil(arg_277_1.actors_["1034ui_story"]) then
					arg_277_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1034ui_story"]) and arg_277_1.var_.characterEffect1034ui_story then
				arg_277_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_280_2 = 0
			local var_280_3 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:GetWordFromCfg(1103404072)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 15 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 15)

				if (15 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 15)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")

						arg_277_1:RecordAudio("1103404072", var_280_9)
						arg_277_1:RecordAudio("1103404072", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_10 and arg_277_1.time_ < var_280_2 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1103404073 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1103404073
		arg_281_1.duration_ = 9

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1103404074(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if arg_281_1.bgs_.I11o == nil then
				local var_284_0 = Object.Instantiate(arg_281_1.paintGo_)

				var_284_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_284_0.name = "I11o"
				var_284_0.transform.parent = arg_281_1.stage_.transform
				var_284_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.bgs_.I11o = var_284_0
			end

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				local var_284_1 = arg_281_1.bgs_.I11o

				arg_281_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_284_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_2 = var_284_1:GetComponent("SpriteRenderer")

				if var_284_2 and var_284_2.sprite then
					local var_284_3 = 2 * (var_284_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_284_1.transform.localScale = Vector3.New(var_284_3 / var_284_2.sprite.bounds.size.y < var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x and var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x or var_284_3 / var_284_2.sprite.bounds.size.y, var_284_3 / var_284_2.sprite.bounds.size.y < var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x and var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x or var_284_3 / var_284_2.sprite.bounds.size.y, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "I11o" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_4 = 4

			if 4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			if arg_281_1.time_ >= var_284_4 + 0.3 and arg_281_1.time_ < var_284_4 + 0.3 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			local var_284_5 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_6 = 2

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_6 then
				local var_284_7 = Color.New(0, 0, 0)

				var_284_7.a = Mathf.Lerp(0, 1, (arg_281_1.time_ - var_284_5) / var_284_6)
				arg_281_1.mask_.color = var_284_7
			end

			if arg_281_1.time_ >= var_284_5 + var_284_6 and arg_281_1.time_ < var_284_5 + var_284_6 + arg_284_0 then
				local var_284_8 = Color.New(0, 0, 0)

				var_284_8.a = 1
				arg_281_1.mask_.color = var_284_8
			end

			local var_284_9 = 2

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_10 = 2

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_10 then
				local var_284_11 = Color.New(0, 0, 0)

				var_284_11.a = Mathf.Lerp(1, 0, (arg_281_1.time_ - var_284_9) / var_284_10)
				arg_281_1.mask_.color = var_284_11
			end

			if arg_281_1.time_ >= var_284_9 + var_284_10 and arg_281_1.time_ < var_284_9 + var_284_10 + arg_284_0 then
				local var_284_12 = Color.New(0, 0, 0)

				arg_281_1.mask_.enabled = false
				var_284_12.a = 0
				arg_281_1.mask_.color = var_284_12
			end

			local var_284_13 = arg_281_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 1.98333333333333 + arg_284_0 then
				arg_281_1.var_.moveOldPos1034ui_story = var_284_13.localPosition
			end

			local var_284_14 = 0.001

			if 1.98333333333333 <= arg_281_1.time_ and arg_281_1.time_ < 1.98333333333333 + var_284_14 then
				var_284_13.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 1.98333333333333) / var_284_14)
				var_284_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_13.position).x, (manager.ui.mainCamera.transform.position - var_284_13.position).y, (manager.ui.mainCamera.transform.position - var_284_13.position).z)
				var_284_13.localEulerAngles.z = 0
				var_284_13.localEulerAngles.x = 0
				var_284_13.localEulerAngles = var_284_13.localEulerAngles
			end

			if arg_281_1.time_ >= 1.98333333333333 + var_284_14 and arg_281_1.time_ < 1.98333333333333 + var_284_14 + arg_284_0 then
				var_284_13.localPosition = Vector3.New(0, 100, 0)
				var_284_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_13.position).x, (manager.ui.mainCamera.transform.position - var_284_13.position).y, (manager.ui.mainCamera.transform.position - var_284_13.position).z)
				var_284_13.localEulerAngles.z = 0
				var_284_13.localEulerAngles.x = 0
				var_284_13.localEulerAngles = var_284_13.localEulerAngles
			end

			local var_284_15 = arg_281_1.actors_["1034ui_story"]

			if 1.9 < arg_281_1.time_ and arg_281_1.time_ <= 1.9 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect1034ui_story == nil then
				arg_281_1.var_.characterEffect1034ui_story = var_284_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_16 = 0.0833333333333335

			if 1.9 <= arg_281_1.time_ and arg_281_1.time_ < 1.9 + var_284_16 and not isNil(var_284_15) then
				if arg_281_1.var_.characterEffect1034ui_story and not isNil(var_284_15) then
					arg_281_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 1.9) / var_284_16)
				end
			end

			if arg_281_1.time_ >= 1.9 + var_284_16 and arg_281_1.time_ < 1.9 + var_284_16 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect1034ui_story then
				arg_281_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 0.133333333333333 + arg_284_0 then
				arg_281_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_284_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_19 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_19

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_19
						arg_281_1.bgmTxt2_.text = var_284_19
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.56666666666667 < arg_281_1.time_ and arg_281_1.time_ <= 1.56666666666667 + arg_284_0 then
				arg_281_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_284_22 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if "" ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_22 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_22

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_22
						arg_281_1.bgmTxt2_.text = var_284_22
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 0.133333333333333 + arg_284_0 then
				arg_281_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1.56666666666667 < arg_281_1.time_ and arg_281_1.time_ <= 1.56666666666667 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_25 = 4
			local var_284_26 = 1.2

			if 4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_25 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_27 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_27:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_281_1.dialogCg_.alpha = arg_287_0
				end))
				var_284_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_28 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1103404073).content)

				arg_281_1.text_.text = var_284_28

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_30 = 48 <= 0 and var_284_26 or var_284_26 * (utf8.len(var_284_28) / 48)

				if (48 <= 0 and var_284_26 or var_284_26 * (utf8.len(var_284_28) / 48)) > 0 and var_284_26 < var_284_30 then
					arg_281_1.talkMaxDuration = var_284_30
					var_284_25 = var_284_25 + 0.3

					if var_284_30 + var_284_25 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_30 + var_284_25
					end
				end

				arg_281_1.text_.text = var_284_28
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_31 = var_284_25 + 0.3
			local var_284_32 = math.max(var_284_26, arg_281_1.talkMaxDuration)

			if var_284_25 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_31 + var_284_32 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_31) / var_284_32

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_31 + var_284_32 and arg_281_1.time_ < var_284_31 + var_284_32 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1103404074 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1103404074
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1103404075(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.25

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1103404074).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 50 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 50)

				if (50 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 50)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1103404075 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1103404075
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1103404076(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.3

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1103404075).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 52 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 52)

				if (52 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 52)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1103404076 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1103404076
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1103404077(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.45

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1103404076).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 18 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 18)

				if (18 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 18)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1103404077 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1103404077
		arg_301_1.duration_ = 2.2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1103404078(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1034ui_story"]) and arg_301_1.var_.characterEffect1034ui_story == nil then
				arg_301_1.var_.characterEffect1034ui_story = arg_301_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1034ui_story"]) then
				if arg_301_1.var_.characterEffect1034ui_story and not isNil(arg_301_1.actors_["1034ui_story"]) then
					arg_301_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1034ui_story"]) and arg_301_1.var_.characterEffect1034ui_story then
				arg_301_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_304_2 = 0
			local var_304_3 = 0.25

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_301_1.callingController_:SetSelectedState("calling")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_4 = arg_301_1:GetWordFromCfg(1103404077)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 10 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 10)

				if (10 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 10)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")

						arg_301_1:RecordAudio("1103404077", var_304_9)
						arg_301_1:RecordAudio("1103404077", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1103404078 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1103404078
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1103404079(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1034ui_story"]) and arg_305_1.var_.characterEffect1034ui_story == nil then
				arg_305_1.var_.characterEffect1034ui_story = arg_305_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1034ui_story"]) then
				if arg_305_1.var_.characterEffect1034ui_story and not isNil(arg_305_1.actors_["1034ui_story"]) then
					arg_305_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1034ui_story"]) and arg_305_1.var_.characterEffect1034ui_story then
				arg_305_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.825

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1103404078).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 33 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 33)

				if (33 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 33)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1103404079 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1103404079
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1103404080(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.625

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1103404079).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 25 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 25)

				if (25 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 25)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1103404080 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1103404080
		arg_313_1.duration_ = 5.97

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1103404081(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.775

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_313_1.callingController_:SetSelectedState("calling")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_1 = arg_313_1:GetWordFromCfg(1103404080)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 31 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 31)

				if (31 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 31)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")

						arg_313_1:RecordAudio("1103404080", var_316_6)
						arg_313_1:RecordAudio("1103404080", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1103404081 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1103404081
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1103404082(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.566666666666667

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1103404081).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 21 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 21)

				if (21 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 21)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1103404082 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1103404082
		arg_321_1.duration_ = 4.03

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1103404083(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.45

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_321_1.callingController_:SetSelectedState("calling")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:GetWordFromCfg(1103404082)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 18 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 18)

				if (18 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 18)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")

						arg_321_1:RecordAudio("1103404082", var_324_6)
						arg_321_1:RecordAudio("1103404082", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1103404083 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1103404083
		arg_325_1.duration_ = 5.43

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1103404084(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.725

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034")

				arg_325_1.callingController_:SetSelectedState("calling")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(1103404083)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 29 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 29)

				if (29 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 29)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")

						arg_325_1:RecordAudio("1103404083", var_328_6)
						arg_325_1:RecordAudio("1103404083", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1103404084 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1103404084
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1103404085(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1034ui_story"]) and arg_329_1.var_.characterEffect1034ui_story == nil then
				arg_329_1.var_.characterEffect1034ui_story = arg_329_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1034ui_story"]) then
				if arg_329_1.var_.characterEffect1034ui_story and not isNil(arg_329_1.actors_["1034ui_story"]) then
					arg_329_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1034ui_story"]) and arg_329_1.var_.characterEffect1034ui_story then
				arg_329_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_1 = 0
			local var_332_2 = 1.3

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1103404084).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 52 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 52)

				if (52 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 52)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1103404085 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1103404085
		arg_333_1.duration_ = 3.2

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1103404086(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPosI11o = arg_333_1.bgs_.I11o.transform.localPosition
			end

			local var_336_0 = 2.5

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.bgs_.I11o.transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPosI11o, Vector3.New(0, 1, 9.5), (arg_333_1.time_ - 0) / var_336_0)
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_336_1 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			if arg_333_1.time_ >= var_336_1 + 2.5 and arg_333_1.time_ < var_336_1 + 2.5 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end

			if 0.0166666666666666 < arg_333_1.time_ and arg_333_1.time_ <= 0.0166666666666666 + arg_336_0 then
				arg_333_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_336_3 = arg_333_1.actors_["1034ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1034ui_story = var_336_3.localPosition
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_3.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_333_1.time_ - 0) / var_336_4)
				var_336_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_3.position).x, (manager.ui.mainCamera.transform.position - var_336_3.position).y, (manager.ui.mainCamera.transform.position - var_336_3.position).z)
				var_336_3.localEulerAngles.z = 0
				var_336_3.localEulerAngles.x = 0
				var_336_3.localEulerAngles = var_336_3.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_3.localPosition = Vector3.New(0, -0.93, -6)
				var_336_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_3.position).x, (manager.ui.mainCamera.transform.position - var_336_3.position).y, (manager.ui.mainCamera.transform.position - var_336_3.position).z)
				var_336_3.localEulerAngles.z = 0
				var_336_3.localEulerAngles.x = 0
				var_336_3.localEulerAngles = var_336_3.localEulerAngles
			end

			local var_336_5 = arg_333_1.actors_["1034ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.characterEffect1034ui_story == nil then
				arg_333_1.var_.characterEffect1034ui_story = var_336_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_6 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_6 and not isNil(var_336_5) then
				if arg_333_1.var_.characterEffect1034ui_story and not isNil(var_336_5) then
					arg_333_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_6 and arg_333_1.time_ < 0 + var_336_6 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.characterEffect1034ui_story then
				arg_333_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_336_8 = 0
			local var_336_9 = 0.225

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_10 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_10:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_11 = arg_333_1:GetWordFromCfg(1103404085)
				local var_336_12 = arg_333_1:FormatText(var_336_11.content)

				arg_333_1.text_.text = var_336_12

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_14 = 9 <= 0 and var_336_9 or var_336_9 * (utf8.len(var_336_12) / 9)

				if (9 <= 0 and var_336_9 or var_336_9 * (utf8.len(var_336_12) / 9)) > 0 and var_336_9 < var_336_14 then
					arg_333_1.talkMaxDuration = var_336_14
					var_336_8 = var_336_8 + 0.3

					if var_336_14 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_8
					end
				end

				arg_333_1.text_.text = var_336_12
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb") ~= 0 then
					local var_336_15 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb") / 1000

					if var_336_15 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_8
					end

					if var_336_11.prefab_name ~= "" and arg_333_1.actors_[var_336_11.prefab_name] ~= nil then
						local var_336_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_11.prefab_name].transform, "story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")

						arg_333_1:RecordAudio("1103404085", var_336_16)
						arg_333_1:RecordAudio("1103404085", var_336_16)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_17 = var_336_8 + 0.3
			local var_336_18 = math.max(var_336_9, arg_333_1.talkMaxDuration)

			if var_336_8 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_17 + var_336_18 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_17) / var_336_18

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_17 + var_336_18 and arg_333_1.time_ < var_336_17 + var_336_18 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "I11o",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1103404086 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1103404086
		arg_339_1.duration_ = 3.83

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1103404087(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.325

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:GetWordFromCfg(1103404086)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 13 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 13)

				if (13 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 13)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")

						arg_339_1:RecordAudio("1103404086", var_342_6)
						arg_339_1:RecordAudio("1103404086", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1103404087 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1103404087
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1103404088(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 1.35

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1103404087).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 54 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 54)

				if (54 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 54)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1103404088 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1103404088
		arg_347_1.duration_ = 2.13

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1103404089(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_350_0 = arg_347_1.actors_["1034ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1034ui_story = var_350_0.localPosition
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_347_1.time_ - 0) / var_350_1)
				var_350_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_0.position).x, (manager.ui.mainCamera.transform.position - var_350_0.position).y, (manager.ui.mainCamera.transform.position - var_350_0.position).z)
				var_350_0.localEulerAngles.z = 0
				var_350_0.localEulerAngles.x = 0
				var_350_0.localEulerAngles = var_350_0.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, -0.93, -6)
				var_350_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_0.position).x, (manager.ui.mainCamera.transform.position - var_350_0.position).y, (manager.ui.mainCamera.transform.position - var_350_0.position).z)
				var_350_0.localEulerAngles.z = 0
				var_350_0.localEulerAngles.x = 0
				var_350_0.localEulerAngles = var_350_0.localEulerAngles
			end

			local var_350_2 = arg_347_1.actors_["1034ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1034ui_story == nil then
				arg_347_1.var_.characterEffect1034ui_story = var_350_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_3 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.characterEffect1034ui_story and not isNil(var_350_2) then
					arg_347_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1034ui_story then
				arg_347_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_350_5 = 0
			local var_350_6 = 0.15

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(1103404088)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 6 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 6)

				if (6 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 6)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")

						arg_347_1:RecordAudio("1103404088", var_350_12)
						arg_347_1:RecordAudio("1103404088", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play1103404089 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1103404089
		arg_351_1.duration_ = 3.6

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1103404090(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1034ui_story"]) and arg_351_1.var_.characterEffect1034ui_story == nil then
				arg_351_1.var_.characterEffect1034ui_story = arg_351_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1034ui_story"]) then
				if arg_351_1.var_.characterEffect1034ui_story and not isNil(arg_351_1.actors_["1034ui_story"]) then
					arg_351_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1034ui_story"]) and arg_351_1.var_.characterEffect1034ui_story then
				arg_351_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(1103404089)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 10)

				if (10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 10)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")

						arg_351_1:RecordAudio("1103404089", var_354_8)
						arg_351_1:RecordAudio("1103404089", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1103404090 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1103404090
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1103404091(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_358_0 = 0
			local var_358_1 = 1.65

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1103404090).content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 66 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_2) / 66)

				if (66 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_2) / 66)) > 0 and var_358_1 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_5 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_5 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_5

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_5 and arg_355_1.time_ < var_358_0 + var_358_5 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1103404091 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1103404091
		arg_359_1.duration_ = 2.9

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1103404092(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_362_0 = 0
			local var_362_1 = 0.225

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_2 = arg_359_1:GetWordFromCfg(1103404091)
				local var_362_3 = arg_359_1:FormatText(var_362_2.content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 9 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_3) / 9)

				if (9 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_3) / 9)) > 0 and var_362_1 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb") ~= 0 then
					local var_362_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb") / 1000

					if var_362_6 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_0
					end

					if var_362_2.prefab_name ~= "" and arg_359_1.actors_[var_362_2.prefab_name] ~= nil then
						local var_362_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_2.prefab_name].transform, "story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")

						arg_359_1:RecordAudio("1103404091", var_362_7)
						arg_359_1:RecordAudio("1103404091", var_362_7)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_8 and arg_359_1.time_ < var_362_0 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1103404092 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1103404092
		arg_363_1.duration_ = 3.87

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1103404093(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1034ui_story"]) and arg_363_1.var_.characterEffect1034ui_story == nil then
				arg_363_1.var_.characterEffect1034ui_story = arg_363_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1034ui_story"]) then
				if arg_363_1.var_.characterEffect1034ui_story and not isNil(arg_363_1.actors_["1034ui_story"]) then
					arg_363_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1034ui_story"]) and arg_363_1.var_.characterEffect1034ui_story then
				arg_363_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_366_2 = 0
			local var_366_3 = 0.45

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:GetWordFromCfg(1103404092)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 18 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 18)

				if (18 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 18)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")

						arg_363_1:RecordAudio("1103404092", var_366_9)
						arg_363_1:RecordAudio("1103404092", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1103404093 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1103404093
		arg_367_1.duration_ = 2.33

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1103404094(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_370_0 = 0
			local var_370_1 = 0.2

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(1103404093)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 8 <= 0 and var_370_1 or var_370_1 * (utf8.len(var_370_3) / 8)

				if (8 <= 0 and var_370_1 or var_370_1 * (utf8.len(var_370_3) / 8)) > 0 and var_370_1 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb") ~= 0 then
					local var_370_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb") / 1000

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end

					if var_370_2.prefab_name ~= "" and arg_367_1.actors_[var_370_2.prefab_name] ~= nil then
						local var_370_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_2.prefab_name].transform, "story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")

						arg_367_1:RecordAudio("1103404093", var_370_7)
						arg_367_1:RecordAudio("1103404093", var_370_7)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1103404094 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1103404094
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1103404095(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1034ui_story"]) and arg_371_1.var_.characterEffect1034ui_story == nil then
				arg_371_1.var_.characterEffect1034ui_story = arg_371_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1034ui_story"]) then
				if arg_371_1.var_.characterEffect1034ui_story and not isNil(arg_371_1.actors_["1034ui_story"]) then
					arg_371_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1034ui_story"]) and arg_371_1.var_.characterEffect1034ui_story then
				arg_371_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0.566666666666667 < arg_371_1.time_ and arg_371_1.time_ <= 0.566666666666667 + arg_374_0 then
				arg_371_1:AudioAction("play", "effect", "se_story_128", "se_story_128_handcuffs", "")
			end

			local var_374_2 = 0
			local var_374_3 = 1.75

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_4 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1103404094).content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 70 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 70)

				if (70 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 70)) > 0 and var_374_3 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_2
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_3, arg_371_1.talkMaxDuration)

			if var_374_2 <= arg_371_1.time_ and arg_371_1.time_ < var_374_2 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_2) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_2 + var_374_7 and arg_371_1.time_ < var_374_2 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1103404095 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1103404095
		arg_375_1.duration_ = 6.33

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1103404096(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_378_0 = 0
			local var_378_1 = 0.775

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_2 = arg_375_1:GetWordFromCfg(1103404095)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 31 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 31)

				if (31 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 31)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")

						arg_375_1:RecordAudio("1103404095", var_378_7)
						arg_375_1:RecordAudio("1103404095", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1103404096 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1103404096
		arg_379_1.duration_ = 2.83

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1103404097(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.325

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[714].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(1103404096)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 13 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 13)

				if (13 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 13)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")

						arg_379_1:RecordAudio("1103404096", var_382_6)
						arg_379_1:RecordAudio("1103404096", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1103404097 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1103404097
		arg_383_1.duration_ = 3.8

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1103404098(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1034ui_story"]) and arg_383_1.var_.characterEffect1034ui_story == nil then
				arg_383_1.var_.characterEffect1034ui_story = arg_383_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1034ui_story"]) then
				if arg_383_1.var_.characterEffect1034ui_story and not isNil(arg_383_1.actors_["1034ui_story"]) then
					arg_383_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1034ui_story"]) and arg_383_1.var_.characterEffect1034ui_story then
				arg_383_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_386_2 = 0
			local var_386_3 = 0.5

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(1103404097)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 20 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 20)

				if (20 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 20)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")

						arg_383_1:RecordAudio("1103404097", var_386_9)
						arg_383_1:RecordAudio("1103404097", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1103404098 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1103404098
		arg_387_1.duration_ = 5.53

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1103404099(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_390_0 = 0
			local var_390_1 = 0.675

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(1103404098)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 27 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 27)

				if (27 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 27)) > 0 and var_390_1 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb") ~= 0 then
					local var_390_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb") / 1000

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end

					if var_390_2.prefab_name ~= "" and arg_387_1.actors_[var_390_2.prefab_name] ~= nil then
						local var_390_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_2.prefab_name].transform, "story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")

						arg_387_1:RecordAudio("1103404098", var_390_7)
						arg_387_1:RecordAudio("1103404098", var_390_7)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1103404099 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1103404099
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1103404100(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1034ui_story = arg_391_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).z)
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles = arg_391_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1034ui_story"].transform.position).z)
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1034ui_story"].transform.localEulerAngles = arg_391_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_394_1 = 1

			if 1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.allBtn_.enabled = false
			end

			if arg_391_1.time_ >= var_394_1 + 0.4 and arg_391_1.time_ < var_394_1 + 0.4 + arg_394_0 then
				arg_391_1.allBtn_.enabled = true
			end

			if 1 < arg_391_1.time_ and arg_391_1.time_ <= 1 + arg_394_0 then
				arg_391_1:AudioAction("play", "effect", "se_story_15", "se_story_15_kick", "")
			end

			local var_394_3 = 0
			local var_394_4 = 1.4

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_5 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_5:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_6 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1103404099).content)

				arg_391_1.text_.text = var_394_6

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_8 = 56 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_6) / 56)

				if (56 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_6) / 56)) > 0 and var_394_4 < var_394_8 then
					arg_391_1.talkMaxDuration = var_394_8
					var_394_3 = var_394_3 + 0.3

					if var_394_8 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_3
					end
				end

				arg_391_1.text_.text = var_394_6
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_9 = var_394_3 + 0.3
			local var_394_10 = math.max(var_394_4, arg_391_1.talkMaxDuration)

			if var_394_3 + 0.3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_9 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_9) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_9 + var_394_10 and arg_391_1.time_ < var_394_9 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "I11o",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.233333333333333,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.2, 0.2, 0.2)
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1103404100 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1103404100
		arg_397_1.duration_ = 2.3

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1103404101(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1034ui_story"]) and arg_397_1.var_.characterEffect1034ui_story == nil then
				arg_397_1.var_.characterEffect1034ui_story = arg_397_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1034ui_story"]) then
				if arg_397_1.var_.characterEffect1034ui_story and not isNil(arg_397_1.actors_["1034ui_story"]) then
					arg_397_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1034ui_story"]) and arg_397_1.var_.characterEffect1034ui_story then
				arg_397_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_400_2 = arg_397_1.actors_["1034ui_story"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1034ui_story = var_400_2.localPosition
			end

			local var_400_3 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 then
				var_400_2.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_397_1.time_ - 0) / var_400_3)
				var_400_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_2.position).x, (manager.ui.mainCamera.transform.position - var_400_2.position).y, (manager.ui.mainCamera.transform.position - var_400_2.position).z)
				var_400_2.localEulerAngles.z = 0
				var_400_2.localEulerAngles.x = 0
				var_400_2.localEulerAngles = var_400_2.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 then
				var_400_2.localPosition = Vector3.New(0, -0.93, -6)
				var_400_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_2.position).x, (manager.ui.mainCamera.transform.position - var_400_2.position).y, (manager.ui.mainCamera.transform.position - var_400_2.position).z)
				var_400_2.localEulerAngles.z = 0
				var_400_2.localEulerAngles.x = 0
				var_400_2.localEulerAngles = var_400_2.localEulerAngles
			end

			local var_400_4 = 0
			local var_400_5 = 0.225

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_6 = arg_397_1:GetWordFromCfg(1103404100)
				local var_400_7 = arg_397_1:FormatText(var_400_6.content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 9 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 9)

				if (9 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 9)) > 0 and var_400_5 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_4
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb") ~= 0 then
					local var_400_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb") / 1000

					if var_400_10 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_4
					end

					if var_400_6.prefab_name ~= "" and arg_397_1.actors_[var_400_6.prefab_name] ~= nil then
						local var_400_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_6.prefab_name].transform, "story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")

						arg_397_1:RecordAudio("1103404100", var_400_11)
						arg_397_1:RecordAudio("1103404100", var_400_11)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_12 = math.max(var_400_5, arg_397_1.talkMaxDuration)

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_12 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_4) / var_400_12

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_4 + var_400_12 and arg_397_1.time_ < var_400_4 + var_400_12 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play1103404101 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1103404101
		arg_401_1.duration_ = 3.8

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1103404102(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034ui_story = arg_401_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).z)
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles = arg_401_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_401_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1034ui_story"].transform.position).z)
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1034ui_story"].transform.localEulerAngles = arg_401_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1034ui_story"].transform

			if 0.533333333333333 < arg_401_1.time_ and arg_401_1.time_ <= 0.533333333333333 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034ui_story = var_404_1.localPosition
			end

			local var_404_2 = 0.001

			if 0.533333333333333 <= arg_401_1.time_ and arg_401_1.time_ < 0.533333333333333 + var_404_2 then
				var_404_1.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_401_1.time_ - 0.533333333333333) / var_404_2)
				var_404_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_1.position).x, (manager.ui.mainCamera.transform.position - var_404_1.position).y, (manager.ui.mainCamera.transform.position - var_404_1.position).z)
				var_404_1.localEulerAngles.z = 0
				var_404_1.localEulerAngles.x = 0
				var_404_1.localEulerAngles = var_404_1.localEulerAngles
			end

			if arg_401_1.time_ >= 0.533333333333333 + var_404_2 and arg_401_1.time_ < 0.533333333333333 + var_404_2 + arg_404_0 then
				var_404_1.localPosition = Vector3.New(0, -0.93, -6)
				var_404_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_1.position).x, (manager.ui.mainCamera.transform.position - var_404_1.position).y, (manager.ui.mainCamera.transform.position - var_404_1.position).z)
				var_404_1.localEulerAngles.z = 0
				var_404_1.localEulerAngles.x = 0
				var_404_1.localEulerAngles = var_404_1.localEulerAngles
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_punch", "")
			end

			if 0.533333333333333 < arg_401_1.time_ and arg_401_1.time_ <= 0.533333333333333 + arg_404_0 then
				arg_401_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0.533333333333333 < arg_401_1.time_ and arg_401_1.time_ <= 0.533333333333333 + arg_404_0 then
				arg_401_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if arg_401_1.frameCnt_ <= 1 then
				arg_401_1.dialog_:SetActive(false)
			end

			local var_404_4 = 0.533333333333333
			local var_404_5 = 0.375

			if 0.533333333333333 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				arg_401_1.dialog_:SetActive(true)

				arg_401_1.dialogCg_.alpha = 0

				local var_404_6 = LeanTween.value(arg_401_1.dialog_, 0, 1, 0.3)

				var_404_6:setOnUpdate(LuaHelper.FloatAction(function(arg_405_0)
					arg_401_1.dialogCg_.alpha = arg_405_0
				end))
				var_404_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_401_1.dialog_)
					var_404_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_401_1.duration_ = arg_401_1.duration_ + 0.3

				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:GetWordFromCfg(1103404101)
				local var_404_8 = arg_401_1:FormatText(var_404_7.content)

				arg_401_1.text_.text = var_404_8

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_10 = 15 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_8) / 15)

				if (15 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_8) / 15)) > 0 and var_404_5 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10
					var_404_4 = var_404_4 + 0.3

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_8
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb") ~= 0 then
					local var_404_11 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb") / 1000

					if var_404_11 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_4
					end

					if var_404_7.prefab_name ~= "" and arg_401_1.actors_[var_404_7.prefab_name] ~= nil then
						local var_404_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_7.prefab_name].transform, "story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")

						arg_401_1:RecordAudio("1103404101", var_404_12)
						arg_401_1:RecordAudio("1103404101", var_404_12)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_13 = var_404_4 + 0.3
			local var_404_14 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 + 0.3 <= arg_401_1.time_ and arg_401_1.time_ < var_404_13 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_13) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_13 + var_404_14 and arg_401_1.time_ < var_404_13 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "I11o",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.2, 0.2, 0.2)
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1103404102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1103404102
		arg_407_1.duration_ = 5.2

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1103404103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.675

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:GetWordFromCfg(1103404102)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 27 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 27)

				if (27 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 27)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")

						arg_407_1:RecordAudio("1103404102", var_410_6)
						arg_407_1:RecordAudio("1103404102", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1103404103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1103404103
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1103404104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			if 1.17961196366423e-16 < arg_411_1.time_ and arg_411_1.time_ <= 1.17961196366423e-16 + arg_414_0 then
				arg_411_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_414_0 = 0
			local var_414_1 = 1.5

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1103404103).content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 60 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_2) / 60)

				if (60 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_2) / 60)) > 0 and var_414_1 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_5 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_5 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_5

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_5 and arg_411_1.time_ < var_414_0 + var_414_5 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1103404104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1103404104
		arg_415_1.duration_ = 2

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1103404105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1034ui_story"]) and arg_415_1.var_.characterEffect1034ui_story == nil then
				arg_415_1.var_.characterEffect1034ui_story = arg_415_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1034ui_story"]) then
				if arg_415_1.var_.characterEffect1034ui_story and not isNil(arg_415_1.actors_["1034ui_story"]) then
					arg_415_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1034ui_story"]) and arg_415_1.var_.characterEffect1034ui_story then
				arg_415_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_418_2 = arg_415_1.actors_["1034ui_story"].transform

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1034ui_story = var_418_2.localPosition
			end

			local var_418_3 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_3 then
				var_418_2.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_415_1.time_ - 0) / var_418_3)
				var_418_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_2.position).x, (manager.ui.mainCamera.transform.position - var_418_2.position).y, (manager.ui.mainCamera.transform.position - var_418_2.position).z)
				var_418_2.localEulerAngles.z = 0
				var_418_2.localEulerAngles.x = 0
				var_418_2.localEulerAngles = var_418_2.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_3 and arg_415_1.time_ < 0 + var_418_3 + arg_418_0 then
				var_418_2.localPosition = Vector3.New(0, -0.93, -6)
				var_418_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_2.position).x, (manager.ui.mainCamera.transform.position - var_418_2.position).y, (manager.ui.mainCamera.transform.position - var_418_2.position).z)
				var_418_2.localEulerAngles.z = 0
				var_418_2.localEulerAngles.x = 0
				var_418_2.localEulerAngles = var_418_2.localEulerAngles
			end

			local var_418_4 = 0
			local var_418_5 = 0.425

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(1103404104)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 17 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 17)

				if (17 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 17)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")

						arg_415_1:RecordAudio("1103404104", var_418_11)
						arg_415_1:RecordAudio("1103404104", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1103404105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1103404105
		arg_419_1.duration_ = 3.37

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1103404106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_422_0 = 0
			local var_422_1 = 0.35

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(1103404105)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 14 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 14)

				if (14 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 14)) > 0 and var_422_1 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb") ~= 0 then
					local var_422_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb") / 1000

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end

					if var_422_2.prefab_name ~= "" and arg_419_1.actors_[var_422_2.prefab_name] ~= nil then
						local var_422_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_2.prefab_name].transform, "story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")

						arg_419_1:RecordAudio("1103404105", var_422_7)
						arg_419_1:RecordAudio("1103404105", var_422_7)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1103404106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1103404106
		arg_423_1.duration_ = 9

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1103404107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 2 < arg_423_1.time_ and arg_423_1.time_ <= 2 + arg_426_0 then
				local var_426_0 = arg_423_1.bgs_.I11p

				arg_423_1.bgs_.I11p.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_1 = var_426_0:GetComponent("SpriteRenderer")

				if var_426_1 and var_426_1.sprite then
					local var_426_2 = 2 * (var_426_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_0.transform.localScale = Vector3.New(var_426_2 / var_426_1.sprite.bounds.size.y < var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x and var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x or var_426_2 / var_426_1.sprite.bounds.size.y, var_426_2 / var_426_1.sprite.bounds.size.y < var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x and var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x or var_426_2 / var_426_1.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "I11p" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_3 = 4

			if 4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			if arg_423_1.time_ >= var_426_3 + 0.3 and arg_423_1.time_ < var_426_3 + 0.3 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_4 = 0

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_5 = 2

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_5 then
				local var_426_6 = Color.New(0, 0, 0)

				var_426_6.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_4) / var_426_5)
				arg_423_1.mask_.color = var_426_6
			end

			if arg_423_1.time_ >= var_426_4 + var_426_5 and arg_423_1.time_ < var_426_4 + var_426_5 + arg_426_0 then
				local var_426_7 = Color.New(0, 0, 0)

				var_426_7.a = 1
				arg_423_1.mask_.color = var_426_7
			end

			local var_426_8 = 2

			if 2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_9 = 2

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 then
				local var_426_10 = Color.New(0, 0, 0)

				var_426_10.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_8) / var_426_9)
				arg_423_1.mask_.color = var_426_10
			end

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 then
				local var_426_11 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_11.a = 0
				arg_423_1.mask_.color = var_426_11
			end

			local var_426_12 = arg_423_1.actors_["1034ui_story"].transform

			if 1.96599999815226 < arg_423_1.time_ and arg_423_1.time_ <= 1.96599999815226 + arg_426_0 then
				arg_423_1.var_.moveOldPos1034ui_story = var_426_12.localPosition
			end

			local var_426_13 = 0.001

			if 1.96599999815226 <= arg_423_1.time_ and arg_423_1.time_ < 1.96599999815226 + var_426_13 then
				var_426_12.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 1.96599999815226) / var_426_13)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			if arg_423_1.time_ >= 1.96599999815226 + var_426_13 and arg_423_1.time_ < 1.96599999815226 + var_426_13 + arg_426_0 then
				var_426_12.localPosition = Vector3.New(0, 100, 0)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			local var_426_14 = arg_423_1.actors_["1034ui_story"]

			if 1.96599999815226 < arg_423_1.time_ and arg_423_1.time_ <= 1.96599999815226 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1034ui_story == nil then
				arg_423_1.var_.characterEffect1034ui_story = var_426_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_15 = 0.034000001847744

			if 1.96599999815226 <= arg_423_1.time_ and arg_423_1.time_ < 1.96599999815226 + var_426_15 and not isNil(var_426_14) then
				if arg_423_1.var_.characterEffect1034ui_story and not isNil(var_426_14) then
					arg_423_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 1.96599999815226) / var_426_15)
				end
			end

			if arg_423_1.time_ >= 1.96599999815226 + var_426_15 and arg_423_1.time_ < 1.96599999815226 + var_426_15 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1034ui_story then
				arg_423_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0.233333333333333 < arg_423_1.time_ and arg_423_1.time_ <= 0.233333333333333 + arg_426_0 then
				arg_423_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_426_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_423_1.bgmTxt_.text ~= var_426_18 and arg_423_1.bgmTxt_.text ~= "" then
						if arg_423_1.bgmTxt2_.text ~= "" then
							arg_423_1.bgmTxt_.text = arg_423_1.bgmTxt2_.text
						end

						arg_423_1.bgmTxt2_.text = var_426_18

						arg_423_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_423_1.bgmTxt_.text = var_426_18
						arg_423_1.bgmTxt2_.text = var_426_18
					end

					if arg_423_1.bgmTimer then
						arg_423_1.bgmTimer:Stop()

						arg_423_1.bgmTimer = nil
					end

					if arg_423_1.settingData.show_music_name == 1 then
						arg_423_1.musicController:SetSelectedState("show")
						arg_423_1.musicAnimator_:Play("open", 0, 0)

						if arg_423_1.settingData.music_time ~= 0 then
							arg_423_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_423_1.settingData.music_time), function()
								if arg_423_1 == nil or isNil(arg_423_1.bgmTxt_) then
									return
								end

								arg_423_1.musicController:SetSelectedState("hide")
								arg_423_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_423_1.time_ and arg_423_1.time_ <= 0.233333333333333 + arg_426_0 then
				arg_423_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.56666666666667 < arg_423_1.time_ and arg_423_1.time_ <= 1.56666666666667 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_21 = 4
			local var_426_22 = 1.65

			if 4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_21 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_23 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_23:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_423_1.dialogCg_.alpha = arg_428_0
				end))
				var_426_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_24 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1103404106).content)

				arg_423_1.text_.text = var_426_24

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_26 = 66 <= 0 and var_426_22 or var_426_22 * (utf8.len(var_426_24) / 66)

				if (66 <= 0 and var_426_22 or var_426_22 * (utf8.len(var_426_24) / 66)) > 0 and var_426_22 < var_426_26 then
					arg_423_1.talkMaxDuration = var_426_26
					var_426_21 = var_426_21 + 0.3

					if var_426_26 + var_426_21 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_26 + var_426_21
					end
				end

				arg_423_1.text_.text = var_426_24
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_27 = var_426_21 + 0.3
			local var_426_28 = math.max(var_426_22, arg_423_1.talkMaxDuration)

			if var_426_21 + 0.3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_27 + var_426_28 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_27) / var_426_28

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_27 + var_426_28 and arg_423_1.time_ < var_426_27 + var_426_28 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1103404107 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1103404107
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1103404108(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 1.35

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1103404107).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 54 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 54)

				if (54 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 54)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1103404108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1103404108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1103404109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.525

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(1103404108).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 21 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 21)

				if (21 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 21)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1103404109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1103404109
		arg_438_1.duration_ = 5.4

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1103404110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1034ui_story = arg_438_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_441_0 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				arg_438_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).z)
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles = arg_438_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				arg_438_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_438_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1034ui_story"].transform.position).z)
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1034ui_story"].transform.localEulerAngles = arg_438_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_441_1 = arg_438_1.actors_["1034ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1034ui_story == nil then
				arg_438_1.var_.characterEffect1034ui_story = var_441_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_2 and not isNil(var_441_1) then
				if arg_438_1.var_.characterEffect1034ui_story and not isNil(var_441_1) then
					arg_438_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_2 and arg_438_1.time_ < 0 + var_441_2 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1034ui_story then
				arg_438_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_441_4 = 0
			local var_441_5 = 0.45

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(1103404109)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 18 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 18)

				if (18 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 18)) > 0 and var_441_5 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb") ~= 0 then
					local var_441_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb") / 1000

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end

					if var_441_6.prefab_name ~= "" and arg_438_1.actors_[var_441_6.prefab_name] ~= nil then
						local var_441_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_6.prefab_name].transform, "story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")

						arg_438_1:RecordAudio("1103404109", var_441_11)
						arg_438_1:RecordAudio("1103404109", var_441_11)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_12 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_12 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_12

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_12 and arg_438_1.time_ < var_441_4 + var_441_12 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play1103404110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1103404110
		arg_442_1.duration_ = 5.27

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1103404111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_445_0 = 0
			local var_445_1 = 0.625

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(1103404110)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 25 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 25)

				if (25 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 25)) > 0 and var_445_1 < var_445_5 then
					arg_442_1.talkMaxDuration = var_445_5

					if var_445_5 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb") ~= 0 then
					local var_445_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb") / 1000

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end

					if var_445_2.prefab_name ~= "" and arg_442_1.actors_[var_445_2.prefab_name] ~= nil then
						local var_445_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_2.prefab_name].transform, "story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")

						arg_442_1:RecordAudio("1103404110", var_445_7)
						arg_442_1:RecordAudio("1103404110", var_445_7)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1103404111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1103404111
		arg_446_1.duration_ = 3.5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1103404112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_449_0 = 0
			local var_449_1 = 0.5

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(1103404111)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 20 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 20)

				if (20 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 20)) > 0 and var_449_1 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb") ~= 0 then
					local var_449_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb") / 1000

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end

					if var_449_2.prefab_name ~= "" and arg_446_1.actors_[var_449_2.prefab_name] ~= nil then
						local var_449_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_2.prefab_name].transform, "story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")

						arg_446_1:RecordAudio("1103404111", var_449_7)
						arg_446_1:RecordAudio("1103404111", var_449_7)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_8 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_8 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_8

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_8 and arg_446_1.time_ < var_449_0 + var_449_8 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1103404112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1103404112
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1103404113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1034ui_story"]) and arg_450_1.var_.characterEffect1034ui_story == nil then
				arg_450_1.var_.characterEffect1034ui_story = arg_450_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1034ui_story"]) then
				if arg_450_1.var_.characterEffect1034ui_story and not isNil(arg_450_1.actors_["1034ui_story"]) then
					arg_450_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1034ui_story"]) and arg_450_1.var_.characterEffect1034ui_story then
				arg_450_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.4

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1103404112).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 16 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 16)

				if (16 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 16)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1103404113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1103404113
		arg_454_1.duration_ = 8

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1103404114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1034ui_story"]) and arg_454_1.var_.characterEffect1034ui_story == nil then
				arg_454_1.var_.characterEffect1034ui_story = arg_454_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1034ui_story"]) then
				if arg_454_1.var_.characterEffect1034ui_story and not isNil(arg_454_1.actors_["1034ui_story"]) then
					arg_454_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1034ui_story"]) and arg_454_1.var_.characterEffect1034ui_story then
				arg_454_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_457_2 = 0
			local var_457_3 = 1.075

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(1103404113)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 43 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 43)

				if (43 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 43)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")

						arg_454_1:RecordAudio("1103404113", var_457_9)
						arg_454_1:RecordAudio("1103404113", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1103404114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1103404114
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1103404115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1034ui_story"]) and arg_458_1.var_.characterEffect1034ui_story == nil then
				arg_458_1.var_.characterEffect1034ui_story = arg_458_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1034ui_story"]) then
				if arg_458_1.var_.characterEffect1034ui_story and not isNil(arg_458_1.actors_["1034ui_story"]) then
					arg_458_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1034ui_story"]) and arg_458_1.var_.characterEffect1034ui_story then
				arg_458_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 2.77555756156289e-17 < arg_458_1.time_ and arg_458_1.time_ <= 2.77555756156289e-17 + arg_461_0 then
				arg_458_1:AudioAction("play", "effect", "se_story_side_1199", "se_story_1199_clap", "")
			end

			local var_461_2 = 0
			local var_461_3 = 0.925

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(1103404114).content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 37 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 37)

				if (37 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 37)) > 0 and var_461_3 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_7 and arg_458_1.time_ < var_461_2 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1103404115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1103404115
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1103404116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.225

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(1103404115).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 9 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 9)

				if (9 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 9)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1103404116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1103404116
		arg_466_1.duration_ = 5.4

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1103404117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1034ui_story"]) and arg_466_1.var_.characterEffect1034ui_story == nil then
				arg_466_1.var_.characterEffect1034ui_story = arg_466_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1034ui_story"]) then
				if arg_466_1.var_.characterEffect1034ui_story and not isNil(arg_466_1.actors_["1034ui_story"]) then
					arg_466_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1034ui_story"]) and arg_466_1.var_.characterEffect1034ui_story then
				arg_466_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_469_2 = 0
			local var_469_3 = 0.825

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:GetWordFromCfg(1103404116)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 30 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 30)

				if (30 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 30)) > 0 and var_469_3 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb") / 1000

					if var_469_8 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_2
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")

						arg_466_1:RecordAudio("1103404116", var_469_9)
						arg_466_1:RecordAudio("1103404116", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_10 and arg_466_1.time_ < var_469_2 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1103404117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1103404117
		arg_470_1.duration_ = 2.8

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1103404118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_473_0 = 0
			local var_473_1 = 0.35

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_2 = arg_470_1:GetWordFromCfg(1103404117)
				local var_473_3 = arg_470_1:FormatText(var_473_2.content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 14 <= 0 and var_473_1 or var_473_1 * (utf8.len(var_473_3) / 14)

				if (14 <= 0 and var_473_1 or var_473_1 * (utf8.len(var_473_3) / 14)) > 0 and var_473_1 < var_473_5 then
					arg_470_1.talkMaxDuration = var_473_5

					if var_473_5 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb") ~= 0 then
					local var_473_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb") / 1000

					if var_473_6 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_0
					end

					if var_473_2.prefab_name ~= "" and arg_470_1.actors_[var_473_2.prefab_name] ~= nil then
						local var_473_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_2.prefab_name].transform, "story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")

						arg_470_1:RecordAudio("1103404117", var_473_7)
						arg_470_1:RecordAudio("1103404117", var_473_7)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_8 and arg_470_1.time_ < var_473_0 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1103404118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1103404118
		arg_474_1.duration_ = 9

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1103404119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if arg_474_1.bgs_.R3401 == nil then
				local var_477_0 = Object.Instantiate(arg_474_1.paintGo_)

				var_477_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R3401")
				var_477_0.name = "R3401"
				var_477_0.transform.parent = arg_474_1.stage_.transform
				var_477_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_474_1.bgs_.R3401 = var_477_0
			end

			if 1.98333333333333 < arg_474_1.time_ and arg_474_1.time_ <= 1.98333333333333 + arg_477_0 then
				local var_477_1 = arg_474_1.bgs_.R3401

				arg_474_1.bgs_.R3401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_477_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_477_2 = var_477_1:GetComponent("SpriteRenderer")

				if var_477_2 and var_477_2.sprite then
					local var_477_3 = 2 * (var_477_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_477_1.transform.localScale = Vector3.New(var_477_3 / var_477_2.sprite.bounds.size.y < var_477_3 * manager.ui.mainCameraCom_.aspect / var_477_2.sprite.bounds.size.x and var_477_3 * manager.ui.mainCameraCom_.aspect / var_477_2.sprite.bounds.size.x or var_477_3 / var_477_2.sprite.bounds.size.y, var_477_3 / var_477_2.sprite.bounds.size.y < var_477_3 * manager.ui.mainCameraCom_.aspect / var_477_2.sprite.bounds.size.x and var_477_3 * manager.ui.mainCameraCom_.aspect / var_477_2.sprite.bounds.size.x or var_477_3 / var_477_2.sprite.bounds.size.y, 0)
				end

				for iter_477_0, iter_477_1 in pairs(arg_474_1.bgs_) do
					if iter_477_0 ~= "R3401" then
						iter_477_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_477_4 = 2

			if 2 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.mask_.enabled = true
				arg_474_1.mask_.raycastTarget = true

				arg_474_1:SetGaussion(false)
			end

			local var_477_5 = 2

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_5 then
				local var_477_6 = Color.New(0, 0, 0)

				var_477_6.a = Mathf.Lerp(1, 0, (arg_474_1.time_ - var_477_4) / var_477_5)
				arg_474_1.mask_.color = var_477_6
			end

			if arg_474_1.time_ >= var_477_4 + var_477_5 and arg_474_1.time_ < var_477_4 + var_477_5 + arg_477_0 then
				local var_477_7 = Color.New(0, 0, 0)

				arg_474_1.mask_.enabled = false
				var_477_7.a = 0
				arg_474_1.mask_.color = var_477_7
			end

			local var_477_8 = 0

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				arg_474_1.mask_.enabled = true
				arg_474_1.mask_.raycastTarget = true

				arg_474_1:SetGaussion(false)
			end

			local var_477_9 = 2

			if var_477_8 <= arg_474_1.time_ and arg_474_1.time_ < var_477_8 + var_477_9 then
				local var_477_10 = Color.New(0, 0, 0)

				var_477_10.a = Mathf.Lerp(0, 1, (arg_474_1.time_ - var_477_8) / var_477_9)
				arg_474_1.mask_.color = var_477_10
			end

			if arg_474_1.time_ >= var_477_8 + var_477_9 and arg_474_1.time_ < var_477_8 + var_477_9 + arg_477_0 then
				local var_477_11 = Color.New(0, 0, 0)

				var_477_11.a = 1
				arg_474_1.mask_.color = var_477_11
			end

			local var_477_12 = arg_474_1.actors_["1034ui_story"].transform

			if 1.96599999815226 < arg_474_1.time_ and arg_474_1.time_ <= 1.96599999815226 + arg_477_0 then
				arg_474_1.var_.moveOldPos1034ui_story = var_477_12.localPosition
			end

			local var_477_13 = 0.001

			if 1.96599999815226 <= arg_474_1.time_ and arg_474_1.time_ < 1.96599999815226 + var_477_13 then
				var_477_12.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_474_1.time_ - 1.96599999815226) / var_477_13)
				var_477_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_12.position).x, (manager.ui.mainCamera.transform.position - var_477_12.position).y, (manager.ui.mainCamera.transform.position - var_477_12.position).z)
				var_477_12.localEulerAngles.z = 0
				var_477_12.localEulerAngles.x = 0
				var_477_12.localEulerAngles = var_477_12.localEulerAngles
			end

			if arg_474_1.time_ >= 1.96599999815226 + var_477_13 and arg_474_1.time_ < 1.96599999815226 + var_477_13 + arg_477_0 then
				var_477_12.localPosition = Vector3.New(0, 100, 0)
				var_477_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_12.position).x, (manager.ui.mainCamera.transform.position - var_477_12.position).y, (manager.ui.mainCamera.transform.position - var_477_12.position).z)
				var_477_12.localEulerAngles.z = 0
				var_477_12.localEulerAngles.x = 0
				var_477_12.localEulerAngles = var_477_12.localEulerAngles
			end

			local var_477_14 = arg_474_1.actors_["1034ui_story"]

			if 1.96599999815226 < arg_474_1.time_ and arg_474_1.time_ <= 1.96599999815226 + arg_477_0 and not isNil(var_477_14) and arg_474_1.var_.characterEffect1034ui_story == nil then
				arg_474_1.var_.characterEffect1034ui_story = var_477_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_15 = 0.0340000018477442

			if 1.96599999815226 <= arg_474_1.time_ and arg_474_1.time_ < 1.96599999815226 + var_477_15 and not isNil(var_477_14) then
				if arg_474_1.var_.characterEffect1034ui_story and not isNil(var_477_14) then
					arg_474_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_474_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 1.96599999815226) / var_477_15)
				end
			end

			if arg_474_1.time_ >= 1.96599999815226 + var_477_15 and arg_474_1.time_ < 1.96599999815226 + var_477_15 + arg_477_0 and not isNil(var_477_14) and arg_474_1.var_.characterEffect1034ui_story then
				arg_474_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_474_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_477_16 = arg_474_1.bgs_.R3401.transform

			if 1.98333333333333 < arg_474_1.time_ and arg_474_1.time_ <= 1.98333333333333 + arg_477_0 then
				arg_474_1.var_.moveOldPosR3401 = var_477_16.localPosition
			end

			local var_477_17 = 0.001

			if 1.98333333333333 <= arg_474_1.time_ and arg_474_1.time_ < 1.98333333333333 + var_477_17 then
				var_477_16.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPosR3401, Vector3.New(0, 1, 8), (arg_474_1.time_ - 1.98333333333333) / var_477_17)
			end

			if arg_474_1.time_ >= 1.98333333333333 + var_477_17 and arg_474_1.time_ < 1.98333333333333 + var_477_17 + arg_477_0 then
				var_477_16.localPosition = Vector3.New(0, 1, 8)
			end

			local var_477_18 = arg_474_1.bgs_.R3401.transform

			if 2 < arg_474_1.time_ and arg_474_1.time_ <= 2 + arg_477_0 then
				arg_474_1.var_.moveOldPosR3401 = var_477_18.localPosition
			end

			local var_477_19 = 2

			if 2 <= arg_474_1.time_ and arg_474_1.time_ < 2 + var_477_19 then
				var_477_18.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPosR3401, Vector3.New(0, 1, 10), (arg_474_1.time_ - 2) / var_477_19)
			end

			if arg_474_1.time_ >= 2 + var_477_19 and arg_474_1.time_ < 2 + var_477_19 + arg_477_0 then
				var_477_18.localPosition = Vector3.New(0, 1, 10)
			end

			local var_477_20 = 2

			if 2 < arg_474_1.time_ and arg_474_1.time_ <= var_477_20 + arg_477_0 then
				arg_474_1.allBtn_.enabled = false
			end

			if arg_474_1.time_ >= var_477_20 + 2.23333333333333 and arg_474_1.time_ < var_477_20 + 2.23333333333333 + arg_477_0 then
				arg_474_1.allBtn_.enabled = true
			end

			if 0.3 < arg_474_1.time_ and arg_474_1.time_ <= 0.3 + arg_477_0 then
				arg_474_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_477_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_474_1.bgmTxt_.text ~= var_477_23 and arg_474_1.bgmTxt_.text ~= "" then
						if arg_474_1.bgmTxt2_.text ~= "" then
							arg_474_1.bgmTxt_.text = arg_474_1.bgmTxt2_.text
						end

						arg_474_1.bgmTxt2_.text = var_477_23

						arg_474_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_474_1.bgmTxt_.text = var_477_23
						arg_474_1.bgmTxt2_.text = var_477_23
					end

					if arg_474_1.bgmTimer then
						arg_474_1.bgmTimer:Stop()

						arg_474_1.bgmTimer = nil
					end

					if arg_474_1.settingData.show_music_name == 1 then
						arg_474_1.musicController:SetSelectedState("show")
						arg_474_1.musicAnimator_:Play("open", 0, 0)

						if arg_474_1.settingData.music_time ~= 0 then
							arg_474_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_474_1.settingData.music_time), function()
								if arg_474_1 == nil or isNil(arg_474_1.bgmTxt_) then
									return
								end

								arg_474_1.musicController:SetSelectedState("hide")
								arg_474_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_474_1.time_ and arg_474_1.time_ <= 1.5 + arg_477_0 then
				arg_474_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_477_26 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_474_1.bgmTxt_.text ~= var_477_26 and arg_474_1.bgmTxt_.text ~= "" then
						if arg_474_1.bgmTxt2_.text ~= "" then
							arg_474_1.bgmTxt_.text = arg_474_1.bgmTxt2_.text
						end

						arg_474_1.bgmTxt2_.text = var_477_26

						arg_474_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_474_1.bgmTxt_.text = var_477_26
						arg_474_1.bgmTxt2_.text = var_477_26
					end

					if arg_474_1.bgmTimer then
						arg_474_1.bgmTimer:Stop()

						arg_474_1.bgmTimer = nil
					end

					if arg_474_1.settingData.show_music_name == 1 then
						arg_474_1.musicController:SetSelectedState("show")
						arg_474_1.musicAnimator_:Play("open", 0, 0)

						if arg_474_1.settingData.music_time ~= 0 then
							arg_474_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_474_1.settingData.music_time), function()
								if arg_474_1 == nil or isNil(arg_474_1.bgmTxt_) then
									return
								end

								arg_474_1.musicController:SetSelectedState("hide")
								arg_474_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_474_1.frameCnt_ <= 1 then
				arg_474_1.dialog_:SetActive(false)
			end

			local var_477_27 = 4
			local var_477_28 = 1.225

			if 4 < arg_474_1.time_ and arg_474_1.time_ <= var_477_27 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0

				arg_474_1.dialog_:SetActive(true)

				arg_474_1.dialogCg_.alpha = 0

				local var_477_29 = LeanTween.value(arg_474_1.dialog_, 0, 1, 0.3)

				var_477_29:setOnUpdate(LuaHelper.FloatAction(function(arg_480_0)
					arg_474_1.dialogCg_.alpha = arg_480_0
				end))
				var_477_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_474_1.dialog_)
					var_477_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_474_1.duration_ = arg_474_1.duration_ + 0.3

				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_30 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(1103404118).content)

				arg_474_1.text_.text = var_477_30

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_32 = 49 <= 0 and var_477_28 or var_477_28 * (utf8.len(var_477_30) / 49)

				if (49 <= 0 and var_477_28 or var_477_28 * (utf8.len(var_477_30) / 49)) > 0 and var_477_28 < var_477_32 then
					arg_474_1.talkMaxDuration = var_477_32
					var_477_27 = var_477_27 + 0.3

					if var_477_32 + var_477_27 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_32 + var_477_27
					end
				end

				arg_474_1.text_.text = var_477_30
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_33 = var_477_27 + 0.3
			local var_477_34 = math.max(var_477_28, arg_474_1.talkMaxDuration)

			if var_477_27 + 0.3 <= arg_474_1.time_ and arg_474_1.time_ < var_477_33 + var_477_34 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_33) / var_477_34

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_33 + var_477_34 and arg_474_1.time_ < var_477_33 + var_477_34 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1103404119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1103404119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1103404120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 1.8

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(1103404119).content)

				arg_482_1.text_.text = var_485_1

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_3 = 72 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 72)

				if (72 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 72)) > 0 and var_485_0 < var_485_3 then
					arg_482_1.talkMaxDuration = var_485_3

					if var_485_3 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_3 + 0
					end
				end

				arg_482_1.text_.text = var_485_1
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_4 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_4 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_4

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_4 and arg_482_1.time_ < 0 + var_485_4 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1103404120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1103404120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1103404121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 1.7

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1103404120).content)

				arg_486_1.text_.text = var_489_1

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_3 = 68 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 68)

				if (68 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 68)) > 0 and var_489_0 < var_489_3 then
					arg_486_1.talkMaxDuration = var_489_3

					if var_489_3 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_3 + 0
					end
				end

				arg_486_1.text_.text = var_489_1
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_4 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_4

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1103404121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1103404121
		arg_490_1.duration_ = 6.93

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1103404122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.975

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:GetWordFromCfg(1103404121)
				local var_493_2 = arg_490_1:FormatText(var_493_1.content)

				arg_490_1.text_.text = var_493_2

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 39 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 39)

				if (39 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 39)) > 0 and var_493_0 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end

				arg_490_1.text_.text = var_493_2
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb") ~= 0 then
					local var_493_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb") / 1000

					if var_493_5 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + 0
					end

					if var_493_1.prefab_name ~= "" and arg_490_1.actors_[var_493_1.prefab_name] ~= nil then
						local var_493_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_1.prefab_name].transform, "story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")

						arg_490_1:RecordAudio("1103404121", var_493_6)
						arg_490_1:RecordAudio("1103404121", var_493_6)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1103404122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1103404122
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1103404123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1034ui_story"]) and arg_494_1.var_.characterEffect1034ui_story == nil then
				arg_494_1.var_.characterEffect1034ui_story = arg_494_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1034ui_story"]) then
				if arg_494_1.var_.characterEffect1034ui_story and not isNil(arg_494_1.actors_["1034ui_story"]) then
					arg_494_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1034ui_story"]) and arg_494_1.var_.characterEffect1034ui_story then
				arg_494_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.475

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(1103404122).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 19 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 19)

				if (19 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 19)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1103404123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1103404123
		arg_498_1.duration_ = 4.2

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1103404124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1034ui_story"]) and arg_498_1.var_.characterEffect1034ui_story == nil then
				arg_498_1.var_.characterEffect1034ui_story = arg_498_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1034ui_story"]) then
				if arg_498_1.var_.characterEffect1034ui_story and not isNil(arg_498_1.actors_["1034ui_story"]) then
					arg_498_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1034ui_story"]) and arg_498_1.var_.characterEffect1034ui_story then
				arg_498_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_501_2 = 0
			local var_501_3 = 0.45

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(1103404123)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 18 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 18)

				if (18 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 18)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")

						arg_498_1:RecordAudio("1103404123", var_501_9)
						arg_498_1:RecordAudio("1103404123", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1103404124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1103404124
		arg_502_1.duration_ = 1.57

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1103404125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.05

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:GetWordFromCfg(1103404124)
				local var_505_2 = arg_502_1:FormatText(var_505_1.content)

				arg_502_1.text_.text = var_505_2

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 2 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 2)

				if (2 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 2)) > 0 and var_505_0 < var_505_4 then
					arg_502_1.talkMaxDuration = var_505_4

					if var_505_4 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_4 + 0
					end
				end

				arg_502_1.text_.text = var_505_2
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb") ~= 0 then
					local var_505_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb") / 1000

					if var_505_5 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + 0
					end

					if var_505_1.prefab_name ~= "" and arg_502_1.actors_[var_505_1.prefab_name] ~= nil then
						local var_505_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_1.prefab_name].transform, "story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")

						arg_502_1:RecordAudio("1103404124", var_505_6)
						arg_502_1:RecordAudio("1103404124", var_505_6)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_7 and arg_502_1.time_ < 0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1103404125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1103404125
		arg_506_1.duration_ = 4.4

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1103404126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.4

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:GetWordFromCfg(1103404125)
				local var_509_2 = arg_506_1:FormatText(var_509_1.content)

				arg_506_1.text_.text = var_509_2

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_4 = 16 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_2) / 16)

				if (16 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_2) / 16)) > 0 and var_509_0 < var_509_4 then
					arg_506_1.talkMaxDuration = var_509_4

					if var_509_4 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_4 + 0
					end
				end

				arg_506_1.text_.text = var_509_2
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb") ~= 0 then
					local var_509_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb") / 1000

					if var_509_5 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + 0
					end

					if var_509_1.prefab_name ~= "" and arg_506_1.actors_[var_509_1.prefab_name] ~= nil then
						local var_509_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_1.prefab_name].transform, "story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")

						arg_506_1:RecordAudio("1103404125", var_509_6)
						arg_506_1:RecordAudio("1103404125", var_509_6)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_7 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_7 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_7

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_7 and arg_506_1.time_ < 0 + var_509_7 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1103404126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1103404126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1103404127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1034ui_story"]) and arg_510_1.var_.characterEffect1034ui_story == nil then
				arg_510_1.var_.characterEffect1034ui_story = arg_510_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1034ui_story"]) then
				if arg_510_1.var_.characterEffect1034ui_story and not isNil(arg_510_1.actors_["1034ui_story"]) then
					arg_510_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_0)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1034ui_story"]) and arg_510_1.var_.characterEffect1034ui_story then
				arg_510_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_513_1 = 0
			local var_513_2 = 0.95

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(1103404126).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 38 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 38)

				if (38 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 38)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1103404127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1103404127
		arg_514_1.duration_ = 6.17

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1103404128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1034ui_story"]) and arg_514_1.var_.characterEffect1034ui_story == nil then
				arg_514_1.var_.characterEffect1034ui_story = arg_514_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1034ui_story"]) then
				if arg_514_1.var_.characterEffect1034ui_story and not isNil(arg_514_1.actors_["1034ui_story"]) then
					arg_514_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1034ui_story"]) and arg_514_1.var_.characterEffect1034ui_story then
				arg_514_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_517_2 = 0
			local var_517_3 = 0.8

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_4 = arg_514_1:GetWordFromCfg(1103404127)
				local var_517_5 = arg_514_1:FormatText(var_517_4.content)

				arg_514_1.text_.text = var_517_5

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_7 = 32 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 32)

				if (32 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 32)) > 0 and var_517_3 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_2
					end
				end

				arg_514_1.text_.text = var_517_5
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb") / 1000

					if var_517_8 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_2
					end

					if var_517_4.prefab_name ~= "" and arg_514_1.actors_[var_517_4.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_4.prefab_name].transform, "story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")

						arg_514_1:RecordAudio("1103404127", var_517_9)
						arg_514_1:RecordAudio("1103404127", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_3, arg_514_1.talkMaxDuration)

			if var_517_2 <= arg_514_1.time_ and arg_514_1.time_ < var_517_2 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_2) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_2 + var_517_10 and arg_514_1.time_ < var_517_2 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1103404128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1103404128
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1103404129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1034ui_story"]) and arg_518_1.var_.characterEffect1034ui_story == nil then
				arg_518_1.var_.characterEffect1034ui_story = arg_518_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1034ui_story"]) then
				if arg_518_1.var_.characterEffect1034ui_story and not isNil(arg_518_1.actors_["1034ui_story"]) then
					arg_518_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_0)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1034ui_story"]) and arg_518_1.var_.characterEffect1034ui_story then
				arg_518_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_521_1 = 0
			local var_521_2 = 0.275

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(1103404128).content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 11 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 11)

				if (11 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 11)) > 0 and var_521_2 < var_521_5 then
					arg_518_1.talkMaxDuration = var_521_5

					if var_521_5 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_6 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_6 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_6

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_6 and arg_518_1.time_ < var_521_1 + var_521_6 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play1103404129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1103404129
		arg_522_1.duration_ = 4.4

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1103404130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1034ui_story"]) and arg_522_1.var_.characterEffect1034ui_story == nil then
				arg_522_1.var_.characterEffect1034ui_story = arg_522_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1034ui_story"]) then
				if arg_522_1.var_.characterEffect1034ui_story and not isNil(arg_522_1.actors_["1034ui_story"]) then
					arg_522_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1034ui_story"]) and arg_522_1.var_.characterEffect1034ui_story then
				arg_522_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_525_2 = 0
			local var_525_3 = 0.575

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_4 = arg_522_1:GetWordFromCfg(1103404129)
				local var_525_5 = arg_522_1:FormatText(var_525_4.content)

				arg_522_1.text_.text = var_525_5

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_7 = 23 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 23)

				if (23 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 23)) > 0 and var_525_3 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_2
					end
				end

				arg_522_1.text_.text = var_525_5
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb") / 1000

					if var_525_8 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_2
					end

					if var_525_4.prefab_name ~= "" and arg_522_1.actors_[var_525_4.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_4.prefab_name].transform, "story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")

						arg_522_1:RecordAudio("1103404129", var_525_9)
						arg_522_1:RecordAudio("1103404129", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_3, arg_522_1.talkMaxDuration)

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_2) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_2 + var_525_10 and arg_522_1.time_ < var_525_2 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1103404130 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1103404130
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1103404131(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1034ui_story"]) and arg_526_1.var_.characterEffect1034ui_story == nil then
				arg_526_1.var_.characterEffect1034ui_story = arg_526_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_0 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1034ui_story"]) then
				if arg_526_1.var_.characterEffect1034ui_story and not isNil(arg_526_1.actors_["1034ui_story"]) then
					arg_526_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_526_1.time_ - 0) / var_529_0)
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1034ui_story"]) and arg_526_1.var_.characterEffect1034ui_story then
				arg_526_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_529_1 = 0
			local var_529_2 = 0.475

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(1103404130).content)

				arg_526_1.text_.text = var_529_3

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 19 <= 0 and var_529_2 or var_529_2 * (utf8.len(var_529_3) / 19)

				if (19 <= 0 and var_529_2 or var_529_2 * (utf8.len(var_529_3) / 19)) > 0 and var_529_2 < var_529_5 then
					arg_526_1.talkMaxDuration = var_529_5

					if var_529_5 + var_529_1 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_5 + var_529_1
					end
				end

				arg_526_1.text_.text = var_529_3
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_6 = math.max(var_529_2, arg_526_1.talkMaxDuration)

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_6 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_1) / var_529_6

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_1 + var_529_6 and arg_526_1.time_ < var_529_1 + var_529_6 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play1103404131 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1103404131
		arg_530_1.duration_ = 5.83

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1103404132(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1034ui_story"]) and arg_530_1.var_.characterEffect1034ui_story == nil then
				arg_530_1.var_.characterEffect1034ui_story = arg_530_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1034ui_story"]) then
				if arg_530_1.var_.characterEffect1034ui_story and not isNil(arg_530_1.actors_["1034ui_story"]) then
					arg_530_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1034ui_story"]) and arg_530_1.var_.characterEffect1034ui_story then
				arg_530_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_533_2 = 0
			local var_533_3 = 0.7

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_2 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_4 = arg_530_1:GetWordFromCfg(1103404131)
				local var_533_5 = arg_530_1:FormatText(var_533_4.content)

				arg_530_1.text_.text = var_533_5

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_7 = 28 <= 0 and var_533_3 or var_533_3 * (utf8.len(var_533_5) / 28)

				if (28 <= 0 and var_533_3 or var_533_3 * (utf8.len(var_533_5) / 28)) > 0 and var_533_3 < var_533_7 then
					arg_530_1.talkMaxDuration = var_533_7

					if var_533_7 + var_533_2 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_2
					end
				end

				arg_530_1.text_.text = var_533_5
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb") / 1000

					if var_533_8 + var_533_2 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_2
					end

					if var_533_4.prefab_name ~= "" and arg_530_1.actors_[var_533_4.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_4.prefab_name].transform, "story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")

						arg_530_1:RecordAudio("1103404131", var_533_9)
						arg_530_1:RecordAudio("1103404131", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_10 = math.max(var_533_3, arg_530_1.talkMaxDuration)

			if var_533_2 <= arg_530_1.time_ and arg_530_1.time_ < var_533_2 + var_533_10 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_2) / var_533_10

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_2 + var_533_10 and arg_530_1.time_ < var_533_2 + var_533_10 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1103404132 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1103404132
		arg_534_1.duration_ = 6.4

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1103404133(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0.675

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_1 = arg_534_1:GetWordFromCfg(1103404132)
				local var_537_2 = arg_534_1:FormatText(var_537_1.content)

				arg_534_1.text_.text = var_537_2

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_4 = 27 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 27)

				if (27 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 27)) > 0 and var_537_0 < var_537_4 then
					arg_534_1.talkMaxDuration = var_537_4

					if var_537_4 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_4 + 0
					end
				end

				arg_534_1.text_.text = var_537_2
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb") ~= 0 then
					local var_537_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb") / 1000

					if var_537_5 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_5 + 0
					end

					if var_537_1.prefab_name ~= "" and arg_534_1.actors_[var_537_1.prefab_name] ~= nil then
						local var_537_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_1.prefab_name].transform, "story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")

						arg_534_1:RecordAudio("1103404132", var_537_6)
						arg_534_1:RecordAudio("1103404132", var_537_6)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_7 = math.max(var_537_0, arg_534_1.talkMaxDuration)

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_7 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - 0) / var_537_7

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= 0 + var_537_7 and arg_534_1.time_ < 0 + var_537_7 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1103404133 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1103404133
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1103404134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["1034ui_story"]) and arg_538_1.var_.characterEffect1034ui_story == nil then
				arg_538_1.var_.characterEffect1034ui_story = arg_538_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_0 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["1034ui_story"]) then
				if arg_538_1.var_.characterEffect1034ui_story and not isNil(arg_538_1.actors_["1034ui_story"]) then
					arg_538_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_538_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_538_1.time_ - 0) / var_541_0)
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["1034ui_story"]) and arg_538_1.var_.characterEffect1034ui_story then
				arg_538_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_538_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_541_1 = 0
			local var_541_2 = 0.7

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_3 = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(1103404133).content)

				arg_538_1.text_.text = var_541_3

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_5 = 28 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_3) / 28)

				if (28 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_3) / 28)) > 0 and var_541_2 < var_541_5 then
					arg_538_1.talkMaxDuration = var_541_5

					if var_541_5 + var_541_1 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_5 + var_541_1
					end
				end

				arg_538_1.text_.text = var_541_3
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_6 = math.max(var_541_2, arg_538_1.talkMaxDuration)

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_6 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_1) / var_541_6

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_1 + var_541_6 and arg_538_1.time_ < var_541_1 + var_541_6 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play1103404134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1103404134
		arg_542_1.duration_ = 2.67

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1103404135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["1034ui_story"]) and arg_542_1.var_.characterEffect1034ui_story == nil then
				arg_542_1.var_.characterEffect1034ui_story = arg_542_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["1034ui_story"]) then
				if arg_542_1.var_.characterEffect1034ui_story and not isNil(arg_542_1.actors_["1034ui_story"]) then
					arg_542_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["1034ui_story"]) and arg_542_1.var_.characterEffect1034ui_story then
				arg_542_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_545_2 = 0
			local var_545_3 = 0.2

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_2 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_4 = arg_542_1:GetWordFromCfg(1103404134)
				local var_545_5 = arg_542_1:FormatText(var_545_4.content)

				arg_542_1.text_.text = var_545_5

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_7 = 8 <= 0 and var_545_3 or var_545_3 * (utf8.len(var_545_5) / 8)

				if (8 <= 0 and var_545_3 or var_545_3 * (utf8.len(var_545_5) / 8)) > 0 and var_545_3 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_2
					end
				end

				arg_542_1.text_.text = var_545_5
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb") / 1000

					if var_545_8 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_2
					end

					if var_545_4.prefab_name ~= "" and arg_542_1.actors_[var_545_4.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_4.prefab_name].transform, "story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")

						arg_542_1:RecordAudio("1103404134", var_545_9)
						arg_542_1:RecordAudio("1103404134", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_3, arg_542_1.talkMaxDuration)

			if var_545_2 <= arg_542_1.time_ and arg_542_1.time_ < var_545_2 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_2) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_2 + var_545_10 and arg_542_1.time_ < var_545_2 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1103404135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1103404135
		arg_546_1.duration_ = 10.53

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1103404136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 1.1

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_1 = arg_546_1:GetWordFromCfg(1103404135)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 44 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 44)

				if (44 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 44)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")

						arg_546_1:RecordAudio("1103404135", var_549_6)
						arg_546_1:RecordAudio("1103404135", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1103404136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1103404136
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1103404137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(arg_550_1.actors_["1034ui_story"]) and arg_550_1.var_.characterEffect1034ui_story == nil then
				arg_550_1.var_.characterEffect1034ui_story = arg_550_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_0 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 and not isNil(arg_550_1.actors_["1034ui_story"]) then
				if arg_550_1.var_.characterEffect1034ui_story and not isNil(arg_550_1.actors_["1034ui_story"]) then
					arg_550_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_550_1.time_ - 0) / var_553_0)
				end
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 and not isNil(arg_550_1.actors_["1034ui_story"]) and arg_550_1.var_.characterEffect1034ui_story then
				arg_550_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_553_1 = 0
			local var_553_2 = 0.375

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_3 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(1103404136).content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 15 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 15)

				if (15 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 15)) > 0 and var_553_2 < var_553_5 then
					arg_550_1.talkMaxDuration = var_553_5

					if var_553_5 + var_553_1 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + var_553_1
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_6 = math.max(var_553_2, arg_550_1.talkMaxDuration)

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_6 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_1) / var_553_6

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_1 + var_553_6 and arg_550_1.time_ < var_553_1 + var_553_6 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1103404137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1103404137
		arg_554_1.duration_ = 2.7

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1103404138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0.25

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_1 = arg_554_1:GetWordFromCfg(1103404137)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 10 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 10)

				if (10 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 10)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")

						arg_554_1:RecordAudio("1103404137", var_557_6)
						arg_554_1:RecordAudio("1103404137", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play1103404138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1103404138
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1103404139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["1034ui_story"]) and arg_558_1.var_.characterEffect1034ui_story == nil then
				arg_558_1.var_.characterEffect1034ui_story = arg_558_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_0 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["1034ui_story"]) then
				if arg_558_1.var_.characterEffect1034ui_story and not isNil(arg_558_1.actors_["1034ui_story"]) then
					arg_558_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_0)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["1034ui_story"]) and arg_558_1.var_.characterEffect1034ui_story then
				arg_558_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_561_1 = 0
			local var_561_2 = 0.85

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(1103404138).content)

				arg_558_1.text_.text = var_561_3

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 34 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 34)

				if (34 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 34)) > 0 and var_561_2 < var_561_5 then
					arg_558_1.talkMaxDuration = var_561_5

					if var_561_5 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + var_561_1
					end
				end

				arg_558_1.text_.text = var_561_3
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_6 = math.max(var_561_2, arg_558_1.talkMaxDuration)

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_6 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_1) / var_561_6

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_1 + var_561_6 and arg_558_1.time_ < var_561_1 + var_561_6 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1103404139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1103404139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1103404140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_565_0 = 0
			local var_565_1 = 0.425

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_2 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(1103404139).content)

				arg_562_1.text_.text = var_565_2

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 17 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_2) / 17)

				if (17 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_2) / 17)) > 0 and var_565_1 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_2
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_5 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_5 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_5

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_5 and arg_562_1.time_ < var_565_0 + var_565_5 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1103404140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1103404140
		arg_566_1.duration_ = 2.17

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1103404141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0.225

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_1 = arg_566_1:GetWordFromCfg(1103404140)
				local var_569_2 = arg_566_1:FormatText(var_569_1.content)

				arg_566_1.text_.text = var_569_2

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_4 = 9 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_2) / 9)

				if (9 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_2) / 9)) > 0 and var_569_0 < var_569_4 then
					arg_566_1.talkMaxDuration = var_569_4

					if var_569_4 + 0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_4 + 0
					end
				end

				arg_566_1.text_.text = var_569_2
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb") ~= 0 then
					local var_569_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb") / 1000

					if var_569_5 + 0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_5 + 0
					end

					if var_569_1.prefab_name ~= "" and arg_566_1.actors_[var_569_1.prefab_name] ~= nil then
						local var_569_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_1.prefab_name].transform, "story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")

						arg_566_1:RecordAudio("1103404140", var_569_6)
						arg_566_1:RecordAudio("1103404140", var_569_6)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_7 = math.max(var_569_0, arg_566_1.talkMaxDuration)

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_7 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - 0) / var_569_7

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= 0 + var_569_7 and arg_566_1.time_ < 0 + var_569_7 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play1103404141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1103404141
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1103404142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1034ui_story"]) and arg_570_1.var_.characterEffect1034ui_story == nil then
				arg_570_1.var_.characterEffect1034ui_story = arg_570_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1034ui_story"]) then
				if arg_570_1.var_.characterEffect1034ui_story and not isNil(arg_570_1.actors_["1034ui_story"]) then
					arg_570_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_570_1.time_ - 0) / var_573_0)
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1034ui_story"]) and arg_570_1.var_.characterEffect1034ui_story then
				arg_570_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_573_1 = arg_570_1.bgs_.R3401.transform

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.var_.moveOldPosR3401 = var_573_1.localPosition
			end

			local var_573_2 = 2

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_2 then
				var_573_1.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPosR3401, Vector3.New(0, 1, 9.5), (arg_570_1.time_ - 0) / var_573_2)
			end

			if arg_570_1.time_ >= 0 + var_573_2 and arg_570_1.time_ < 0 + var_573_2 + arg_573_0 then
				var_573_1.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_573_3 = 0
			local var_573_4 = 1.375

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_3 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_5 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(1103404141).content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 55 <= 0 and var_573_4 or var_573_4 * (utf8.len(var_573_5) / 55)

				if (55 <= 0 and var_573_4 or var_573_4 * (utf8.len(var_573_5) / 55)) > 0 and var_573_4 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_3 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_3
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_8 = math.max(var_573_4, arg_570_1.talkMaxDuration)

			if var_573_3 <= arg_570_1.time_ and arg_570_1.time_ < var_573_3 + var_573_8 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_3) / var_573_8

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_3 + var_573_8 and arg_570_1.time_ < var_573_3 + var_573_8 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play1103404142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1103404142
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1103404143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0.15

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_1 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(1103404142).content)

				arg_574_1.text_.text = var_577_1

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_3 = 6 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 6)

				if (6 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 6)) > 0 and var_577_0 < var_577_3 then
					arg_574_1.talkMaxDuration = var_577_3

					if var_577_3 + 0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_3 + 0
					end
				end

				arg_574_1.text_.text = var_577_1
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_4 = math.max(var_577_0, arg_574_1.talkMaxDuration)

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_4 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - 0) / var_577_4

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= 0 + var_577_4 and arg_574_1.time_ < 0 + var_577_4 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1103404143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1103404143
		arg_578_1.duration_ = 2.93

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1103404144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0.45

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_1 = arg_578_1:GetWordFromCfg(1103404143)
				local var_581_2 = arg_578_1:FormatText(var_581_1.content)

				arg_578_1.text_.text = var_581_2

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_4 = 18 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_2) / 18)

				if (18 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_2) / 18)) > 0 and var_581_0 < var_581_4 then
					arg_578_1.talkMaxDuration = var_581_4

					if var_581_4 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_4 + 0
					end
				end

				arg_578_1.text_.text = var_581_2
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb") ~= 0 then
					local var_581_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb") / 1000

					if var_581_5 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_5 + 0
					end

					if var_581_1.prefab_name ~= "" and arg_578_1.actors_[var_581_1.prefab_name] ~= nil then
						local var_581_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_1.prefab_name].transform, "story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")

						arg_578_1:RecordAudio("1103404143", var_581_6)
						arg_578_1:RecordAudio("1103404143", var_581_6)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_7 = math.max(var_581_0, arg_578_1.talkMaxDuration)

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_7 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - 0) / var_581_7

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= 0 + var_581_7 and arg_578_1.time_ < 0 + var_581_7 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1103404144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1103404144
		arg_582_1.duration_ = 3.97

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1103404145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0.425

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_1 = arg_582_1:GetWordFromCfg(1103404144)
				local var_585_2 = arg_582_1:FormatText(var_585_1.content)

				arg_582_1.text_.text = var_585_2

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_4 = 17 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_2) / 17)

				if (17 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_2) / 17)) > 0 and var_585_0 < var_585_4 then
					arg_582_1.talkMaxDuration = var_585_4

					if var_585_4 + 0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_4 + 0
					end
				end

				arg_582_1.text_.text = var_585_2
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb") ~= 0 then
					local var_585_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb") / 1000

					if var_585_5 + 0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_5 + 0
					end

					if var_585_1.prefab_name ~= "" and arg_582_1.actors_[var_585_1.prefab_name] ~= nil then
						local var_585_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_1.prefab_name].transform, "story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")

						arg_582_1:RecordAudio("1103404144", var_585_6)
						arg_582_1:RecordAudio("1103404144", var_585_6)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_7 = math.max(var_585_0, arg_582_1.talkMaxDuration)

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_7 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - 0) / var_585_7

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= 0 + var_585_7 and arg_582_1.time_ < 0 + var_585_7 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1103404145 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1103404145
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1103404146(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["1034ui_story"]) and arg_586_1.var_.characterEffect1034ui_story == nil then
				arg_586_1.var_.characterEffect1034ui_story = arg_586_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_0 = 0.200000002980232

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["1034ui_story"]) then
				if arg_586_1.var_.characterEffect1034ui_story and not isNil(arg_586_1.actors_["1034ui_story"]) then
					arg_586_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_586_1.time_ - 0) / var_589_0)
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["1034ui_story"]) and arg_586_1.var_.characterEffect1034ui_story then
				arg_586_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_589_1 = 0
			local var_589_2 = 1.375

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_3 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(1103404145).content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_5 = 55 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 55)

				if (55 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 55)) > 0 and var_589_2 < var_589_5 then
					arg_586_1.talkMaxDuration = var_589_5

					if var_589_5 + var_589_1 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_5 + var_589_1
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_6 = math.max(var_589_2, arg_586_1.talkMaxDuration)

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_6 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_1) / var_589_6

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_1 + var_589_6 and arg_586_1.time_ < var_589_1 + var_589_6 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1103404146 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1103404146
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1103404147(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_593_0 = 0
			local var_593_1 = 1.425

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, false)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_2 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(1103404146).content)

				arg_590_1.text_.text = var_593_2

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_4 = 57 <= 0 and var_593_1 or var_593_1 * (utf8.len(var_593_2) / 57)

				if (57 <= 0 and var_593_1 or var_593_1 * (utf8.len(var_593_2) / 57)) > 0 and var_593_1 < var_593_4 then
					arg_590_1.talkMaxDuration = var_593_4

					if var_593_4 + var_593_0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_4 + var_593_0
					end
				end

				arg_590_1.text_.text = var_593_2
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_5 = math.max(var_593_1, arg_590_1.talkMaxDuration)

			if var_593_0 <= arg_590_1.time_ and arg_590_1.time_ < var_593_0 + var_593_5 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_0) / var_593_5

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_0 + var_593_5 and arg_590_1.time_ < var_593_0 + var_593_5 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1103404147 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1103404147
		arg_594_1.duration_ = 4.5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1103404148(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.var_.moveOldPosR3401 = arg_594_1.bgs_.R3401.transform.localPosition
			end

			local var_597_0 = 2

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 then
				arg_594_1.bgs_.R3401.transform.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPosR3401, Vector3.New(0, 1, 10), (arg_594_1.time_ - 0) / var_597_0)
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 then
				arg_594_1.bgs_.R3401.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_597_1 = 0
			local var_597_2 = 0.525

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_3 = arg_594_1:GetWordFromCfg(1103404147)
				local var_597_4 = arg_594_1:FormatText(var_597_3.content)

				arg_594_1.text_.text = var_597_4

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_6 = 21 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_4) / 21)

				if (21 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_4) / 21)) > 0 and var_597_2 < var_597_6 then
					arg_594_1.talkMaxDuration = var_597_6

					if var_597_6 + var_597_1 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_6 + var_597_1
					end
				end

				arg_594_1.text_.text = var_597_4
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb") ~= 0 then
					local var_597_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb") / 1000

					if var_597_7 + var_597_1 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_7 + var_597_1
					end

					if var_597_3.prefab_name ~= "" and arg_594_1.actors_[var_597_3.prefab_name] ~= nil then
						local var_597_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_3.prefab_name].transform, "story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")

						arg_594_1:RecordAudio("1103404147", var_597_8)
						arg_594_1:RecordAudio("1103404147", var_597_8)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_9 = math.max(var_597_2, arg_594_1.talkMaxDuration)

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_9 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_1) / var_597_9

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_1 + var_597_9 and arg_594_1.time_ < var_597_1 + var_597_9 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1103404148 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1103404148
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1103404149(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = 0.625

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_1 = arg_598_1:GetWordFromCfg(1103404148)
				local var_601_2 = arg_598_1:FormatText(var_601_1.content)

				arg_598_1.text_.text = var_601_2

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_4 = 25 <= 0 and var_601_0 or var_601_0 * (utf8.len(var_601_2) / 25)

				if (25 <= 0 and var_601_0 or var_601_0 * (utf8.len(var_601_2) / 25)) > 0 and var_601_0 < var_601_4 then
					arg_598_1.talkMaxDuration = var_601_4

					if var_601_4 + 0 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_4 + 0
					end
				end

				arg_598_1.text_.text = var_601_2
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb") ~= 0 then
					local var_601_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb") / 1000

					if var_601_5 + 0 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_5 + 0
					end

					if var_601_1.prefab_name ~= "" and arg_598_1.actors_[var_601_1.prefab_name] ~= nil then
						local var_601_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_1.prefab_name].transform, "story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")

						arg_598_1:RecordAudio("1103404148", var_601_6)
						arg_598_1:RecordAudio("1103404148", var_601_6)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_7 = math.max(var_601_0, arg_598_1.talkMaxDuration)

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_7 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - 0) / var_601_7

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= 0 + var_601_7 and arg_598_1.time_ < 0 + var_601_7 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1103404149 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1103404149
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1103404150(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(arg_602_1.actors_["1034ui_story"]) and arg_602_1.var_.characterEffect1034ui_story == nil then
				arg_602_1.var_.characterEffect1034ui_story = arg_602_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_0 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 and not isNil(arg_602_1.actors_["1034ui_story"]) then
				if arg_602_1.var_.characterEffect1034ui_story and not isNil(arg_602_1.actors_["1034ui_story"]) then
					arg_602_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_602_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_602_1.time_ - 0) / var_605_0)
				end
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 and not isNil(arg_602_1.actors_["1034ui_story"]) and arg_602_1.var_.characterEffect1034ui_story then
				arg_602_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_602_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_605_1 = 0
			local var_605_2 = 0.6

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, true)
				arg_602_1.iconController_:SetSelectedState("hero")

				arg_602_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_602_1.callingController_:SetSelectedState("normal")

				arg_602_1.keyicon_.color = Color.New(1, 1, 1)
				arg_602_1.icon_.color = Color.New(1, 1, 1)

				local var_605_3 = arg_602_1:FormatText(arg_602_1:GetWordFromCfg(1103404149).content)

				arg_602_1.text_.text = var_605_3

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_5 = 24 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_3) / 24)

				if (24 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_3) / 24)) > 0 and var_605_2 < var_605_5 then
					arg_602_1.talkMaxDuration = var_605_5

					if var_605_5 + var_605_1 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_5 + var_605_1
					end
				end

				arg_602_1.text_.text = var_605_3
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_6 = math.max(var_605_2, arg_602_1.talkMaxDuration)

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_6 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_1) / var_605_6

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_1 + var_605_6 and arg_602_1.time_ < var_605_1 + var_605_6 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1103404150 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1103404150
		arg_606_1.duration_ = 6.07

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1103404151(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 0.6

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_1 = arg_606_1:GetWordFromCfg(1103404150)
				local var_609_2 = arg_606_1:FormatText(var_609_1.content)

				arg_606_1.text_.text = var_609_2

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_4 = 24 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 24)

				if (24 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 24)) > 0 and var_609_0 < var_609_4 then
					arg_606_1.talkMaxDuration = var_609_4

					if var_609_4 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_4 + 0
					end
				end

				arg_606_1.text_.text = var_609_2
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb") ~= 0 then
					local var_609_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb") / 1000

					if var_609_5 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_5 + 0
					end

					if var_609_1.prefab_name ~= "" and arg_606_1.actors_[var_609_1.prefab_name] ~= nil then
						local var_609_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_1.prefab_name].transform, "story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")

						arg_606_1:RecordAudio("1103404150", var_609_6)
						arg_606_1:RecordAudio("1103404150", var_609_6)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_7 = math.max(var_609_0, arg_606_1.talkMaxDuration)

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_7 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - 0) / var_609_7

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= 0 + var_609_7 and arg_606_1.time_ < 0 + var_609_7 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1103404151 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1103404151
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1103404152(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 and not isNil(arg_610_1.actors_["1034ui_story"]) and arg_610_1.var_.characterEffect1034ui_story == nil then
				arg_610_1.var_.characterEffect1034ui_story = arg_610_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_0 = 0.200000002980232

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_0 and not isNil(arg_610_1.actors_["1034ui_story"]) then
				if arg_610_1.var_.characterEffect1034ui_story and not isNil(arg_610_1.actors_["1034ui_story"]) then
					arg_610_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_610_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_610_1.time_ - 0) / var_613_0)
				end
			end

			if arg_610_1.time_ >= 0 + var_613_0 and arg_610_1.time_ < 0 + var_613_0 + arg_613_0 and not isNil(arg_610_1.actors_["1034ui_story"]) and arg_610_1.var_.characterEffect1034ui_story then
				arg_610_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_610_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_613_1 = 0
			local var_613_2 = 1.75

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, false)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_3 = arg_610_1:FormatText(arg_610_1:GetWordFromCfg(1103404151).content)

				arg_610_1.text_.text = var_613_3

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_5 = 70 <= 0 and var_613_2 or var_613_2 * (utf8.len(var_613_3) / 70)

				if (70 <= 0 and var_613_2 or var_613_2 * (utf8.len(var_613_3) / 70)) > 0 and var_613_2 < var_613_5 then
					arg_610_1.talkMaxDuration = var_613_5

					if var_613_5 + var_613_1 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_5 + var_613_1
					end
				end

				arg_610_1.text_.text = var_613_3
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_6 = math.max(var_613_2, arg_610_1.talkMaxDuration)

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_6 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_1) / var_613_6

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_1 + var_613_6 and arg_610_1.time_ < var_613_1 + var_613_6 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1103404152 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1103404152
		arg_614_1.duration_ = 8.98

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1103404153(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			if arg_614_1.bgs_["R3401a$naive"] == nil then
				local var_617_0 = Object.Instantiate(arg_614_1.paintGo_)

				var_617_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R3401a$naive")
				var_617_0.name = "R3401a$naive"
				var_617_0.transform.parent = arg_614_1.stage_.transform
				var_617_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.bgs_["R3401a$naive"] = var_617_0
			end

			if 1.98333333333333 < arg_614_1.time_ and arg_614_1.time_ <= 1.98333333333333 + arg_617_0 then
				local var_617_1 = arg_614_1.bgs_["R3401a$naive"]

				arg_614_1.bgs_["R3401a$naive"].transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_617_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_617_2 = var_617_1:GetComponent("SpriteRenderer")

				if var_617_2 and var_617_2.sprite then
					local var_617_3 = 2 * (var_617_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_617_1.transform.localScale = Vector3.New(var_617_3 / var_617_2.sprite.bounds.size.y < var_617_3 * manager.ui.mainCameraCom_.aspect / var_617_2.sprite.bounds.size.x and var_617_3 * manager.ui.mainCameraCom_.aspect / var_617_2.sprite.bounds.size.x or var_617_3 / var_617_2.sprite.bounds.size.y, var_617_3 / var_617_2.sprite.bounds.size.y < var_617_3 * manager.ui.mainCameraCom_.aspect / var_617_2.sprite.bounds.size.x and var_617_3 * manager.ui.mainCameraCom_.aspect / var_617_2.sprite.bounds.size.x or var_617_3 / var_617_2.sprite.bounds.size.y, 0)
				end

				for iter_617_0, iter_617_1 in pairs(arg_614_1.bgs_) do
					if iter_617_0 ~= "R3401a$naive" then
						iter_617_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_617_4 = 0

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_4 + arg_617_0 then
				arg_614_1.mask_.enabled = true
				arg_614_1.mask_.raycastTarget = true

				arg_614_1:SetGaussion(false)
			end

			local var_617_5 = 2

			if var_617_4 <= arg_614_1.time_ and arg_614_1.time_ < var_617_4 + var_617_5 then
				local var_617_6 = Color.New(0, 0, 0)

				var_617_6.a = Mathf.Lerp(0, 1, (arg_614_1.time_ - var_617_4) / var_617_5)
				arg_614_1.mask_.color = var_617_6
			end

			if arg_614_1.time_ >= var_617_4 + var_617_5 and arg_614_1.time_ < var_617_4 + var_617_5 + arg_617_0 then
				local var_617_7 = Color.New(0, 0, 0)

				var_617_7.a = 1
				arg_614_1.mask_.color = var_617_7
			end

			local var_617_8 = 2

			if 2 < arg_614_1.time_ and arg_614_1.time_ <= var_617_8 + arg_617_0 then
				arg_614_1.mask_.enabled = true
				arg_614_1.mask_.raycastTarget = true

				arg_614_1:SetGaussion(false)
			end

			local var_617_9 = 2

			if var_617_8 <= arg_614_1.time_ and arg_614_1.time_ < var_617_8 + var_617_9 then
				local var_617_10 = Color.New(0, 0, 0)

				var_617_10.a = Mathf.Lerp(1, 0, (arg_614_1.time_ - var_617_8) / var_617_9)
				arg_614_1.mask_.color = var_617_10
			end

			if arg_614_1.time_ >= var_617_8 + var_617_9 and arg_614_1.time_ < var_617_8 + var_617_9 + arg_617_0 then
				local var_617_11 = Color.New(0, 0, 0)

				arg_614_1.mask_.enabled = false
				var_617_11.a = 0
				arg_614_1.mask_.color = var_617_11
			end

			local var_617_12 = arg_614_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_614_1.time_ and arg_614_1.time_ <= 1.98333333333333 + arg_617_0 then
				arg_614_1.var_.moveOldPos1034ui_story = var_617_12.localPosition
			end

			local var_617_13 = 0.001

			if 1.98333333333333 <= arg_614_1.time_ and arg_614_1.time_ < 1.98333333333333 + var_617_13 then
				var_617_12.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_614_1.time_ - 1.98333333333333) / var_617_13)
				var_617_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_617_12.position).x, (manager.ui.mainCamera.transform.position - var_617_12.position).y, (manager.ui.mainCamera.transform.position - var_617_12.position).z)
				var_617_12.localEulerAngles.z = 0
				var_617_12.localEulerAngles.x = 0
				var_617_12.localEulerAngles = var_617_12.localEulerAngles
			end

			if arg_614_1.time_ >= 1.98333333333333 + var_617_13 and arg_614_1.time_ < 1.98333333333333 + var_617_13 + arg_617_0 then
				var_617_12.localPosition = Vector3.New(0, 100, 0)
				var_617_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_617_12.position).x, (manager.ui.mainCamera.transform.position - var_617_12.position).y, (manager.ui.mainCamera.transform.position - var_617_12.position).z)
				var_617_12.localEulerAngles.z = 0
				var_617_12.localEulerAngles.x = 0
				var_617_12.localEulerAngles = var_617_12.localEulerAngles
			end

			local var_617_14 = "R3401a"

			if arg_614_1.bgs_.R3401a == nil then
				local var_617_15 = Object.Instantiate(arg_614_1.paintGo_)

				var_617_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_617_14)
				var_617_15.name = var_617_14
				var_617_15.transform.parent = arg_614_1.stage_.transform
				var_617_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.bgs_[var_617_14] = var_617_15
			end

			local var_617_16 = arg_614_1.bgs_.R3401a.transform

			if 1.98333333333333 < arg_614_1.time_ and arg_614_1.time_ <= 1.98333333333333 + arg_617_0 then
				arg_614_1.var_.moveOldPosR3401a = var_617_16.localPosition
			end

			local var_617_17 = 0.001

			if 1.98333333333333 <= arg_614_1.time_ and arg_614_1.time_ < 1.98333333333333 + var_617_17 then
				var_617_16.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPosR3401a, Vector3.New(0, 1, 8), (arg_614_1.time_ - 1.98333333333333) / var_617_17)
			end

			if arg_614_1.time_ >= 1.98333333333333 + var_617_17 and arg_614_1.time_ < 1.98333333333333 + var_617_17 + arg_617_0 then
				var_617_16.localPosition = Vector3.New(0, 1, 8)
			end

			local var_617_18 = arg_614_1.bgs_.R3401a.transform

			if 2 < arg_614_1.time_ and arg_614_1.time_ <= 2 + arg_617_0 then
				arg_614_1.var_.moveOldPosR3401a = var_617_18.localPosition
			end

			local var_617_19 = 2

			if 2 <= arg_614_1.time_ and arg_614_1.time_ < 2 + var_617_19 then
				var_617_18.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPosR3401a, Vector3.New(0, 1, 9.5), (arg_614_1.time_ - 2) / var_617_19)
			end

			if arg_614_1.time_ >= 2 + var_617_19 and arg_614_1.time_ < 2 + var_617_19 + arg_617_0 then
				var_617_18.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_617_20 = 2

			if 2 < arg_614_1.time_ and arg_614_1.time_ <= var_617_20 + arg_617_0 then
				arg_614_1.allBtn_.enabled = false
			end

			if arg_614_1.time_ >= var_617_20 + 1.98333333333333 and arg_614_1.time_ < var_617_20 + 1.98333333333333 + arg_617_0 then
				arg_614_1.allBtn_.enabled = true
			end

			if arg_614_1.frameCnt_ <= 1 then
				arg_614_1.dialog_:SetActive(false)
			end

			local var_617_21 = 3.98333333333333
			local var_617_22 = 1.8

			if 3.98333333333333 < arg_614_1.time_ and arg_614_1.time_ <= var_617_21 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0

				arg_614_1.dialog_:SetActive(true)

				arg_614_1.dialogCg_.alpha = 0

				local var_617_23 = LeanTween.value(arg_614_1.dialog_, 0, 1, 0.3)

				var_617_23:setOnUpdate(LuaHelper.FloatAction(function(arg_618_0)
					arg_614_1.dialogCg_.alpha = arg_618_0
				end))
				var_617_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_614_1.dialog_)
					var_617_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_614_1.duration_ = arg_614_1.duration_ + 0.3

				SetActive(arg_614_1.leftNameGo_, false)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_24 = arg_614_1:FormatText(arg_614_1:GetWordFromCfg(1103404152).content)

				arg_614_1.text_.text = var_617_24

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_26 = 72 <= 0 and var_617_22 or var_617_22 * (utf8.len(var_617_24) / 72)

				if (72 <= 0 and var_617_22 or var_617_22 * (utf8.len(var_617_24) / 72)) > 0 and var_617_22 < var_617_26 then
					arg_614_1.talkMaxDuration = var_617_26
					var_617_21 = var_617_21 + 0.3

					if var_617_26 + var_617_21 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_26 + var_617_21
					end
				end

				arg_614_1.text_.text = var_617_24
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)
				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_27 = var_617_21 + 0.3
			local var_617_28 = math.max(var_617_22, arg_614_1.talkMaxDuration)

			if var_617_21 + 0.3 <= arg_614_1.time_ and arg_614_1.time_ < var_617_27 + var_617_28 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_27) / var_617_28

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_27 + var_617_28 and arg_614_1.time_ < var_617_27 + var_617_28 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R3401a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play1103404153 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1103404153
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1103404154(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 1.55

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_1 = arg_620_1:FormatText(arg_620_1:GetWordFromCfg(1103404153).content)

				arg_620_1.text_.text = var_623_1

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_3 = 62 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 62)

				if (62 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 62)) > 0 and var_623_0 < var_623_3 then
					arg_620_1.talkMaxDuration = var_623_3

					if var_623_3 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_3 + 0
					end
				end

				arg_620_1.text_.text = var_623_1
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_4 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_4 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_4

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_4 and arg_620_1.time_ < 0 + var_623_4 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play1103404154 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1103404154
		arg_624_1.duration_ = 3.87

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1103404155(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0.6

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_1 = arg_624_1:GetWordFromCfg(1103404154)
				local var_627_2 = arg_624_1:FormatText(var_627_1.content)

				arg_624_1.text_.text = var_627_2

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_4 = 24 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_2) / 24)

				if (24 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_2) / 24)) > 0 and var_627_0 < var_627_4 then
					arg_624_1.talkMaxDuration = var_627_4

					if var_627_4 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_4 + 0
					end
				end

				arg_624_1.text_.text = var_627_2
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb") ~= 0 then
					local var_627_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb") / 1000

					if var_627_5 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_5 + 0
					end

					if var_627_1.prefab_name ~= "" and arg_624_1.actors_[var_627_1.prefab_name] ~= nil then
						local var_627_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_1.prefab_name].transform, "story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")

						arg_624_1:RecordAudio("1103404154", var_627_6)
						arg_624_1:RecordAudio("1103404154", var_627_6)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_7 = math.max(var_627_0, arg_624_1.talkMaxDuration)

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_7 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - 0) / var_627_7

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= 0 + var_627_7 and arg_624_1.time_ < 0 + var_627_7 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R3401a",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.166666666666667,
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.05, 0.05, 0.05)
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	Play1103404155 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1103404155
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1103404156(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(arg_628_1.actors_["1034ui_story"]) and arg_628_1.var_.characterEffect1034ui_story == nil then
				arg_628_1.var_.characterEffect1034ui_story = arg_628_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_0 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 and not isNil(arg_628_1.actors_["1034ui_story"]) then
				if arg_628_1.var_.characterEffect1034ui_story and not isNil(arg_628_1.actors_["1034ui_story"]) then
					arg_628_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_628_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_628_1.time_ - 0) / var_631_0)
				end
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 and not isNil(arg_628_1.actors_["1034ui_story"]) and arg_628_1.var_.characterEffect1034ui_story then
				arg_628_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_628_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_631_1 = 0
			local var_631_2 = 0.35

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, true)
				arg_628_1.iconController_:SetSelectedState("hero")

				arg_628_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_628_1.callingController_:SetSelectedState("normal")

				arg_628_1.keyicon_.color = Color.New(1, 1, 1)
				arg_628_1.icon_.color = Color.New(1, 1, 1)

				local var_631_3 = arg_628_1:FormatText(arg_628_1:GetWordFromCfg(1103404155).content)

				arg_628_1.text_.text = var_631_3

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_5 = 14 <= 0 and var_631_2 or var_631_2 * (utf8.len(var_631_3) / 14)

				if (14 <= 0 and var_631_2 or var_631_2 * (utf8.len(var_631_3) / 14)) > 0 and var_631_2 < var_631_5 then
					arg_628_1.talkMaxDuration = var_631_5

					if var_631_5 + var_631_1 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_5 + var_631_1
					end
				end

				arg_628_1.text_.text = var_631_3
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_6 = math.max(var_631_2, arg_628_1.talkMaxDuration)

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_6 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_1) / var_631_6

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_1 + var_631_6 and arg_628_1.time_ < var_631_1 + var_631_6 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play1103404156 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1103404156
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1103404157(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_2")
			end

			local var_635_0 = 0
			local var_635_1 = 0.45

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_2 = arg_632_1:FormatText(arg_632_1:GetWordFromCfg(1103404156).content)

				arg_632_1.text_.text = var_635_2

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_4 = 18 <= 0 and var_635_1 or var_635_1 * (utf8.len(var_635_2) / 18)

				if (18 <= 0 and var_635_1 or var_635_1 * (utf8.len(var_635_2) / 18)) > 0 and var_635_1 < var_635_4 then
					arg_632_1.talkMaxDuration = var_635_4

					if var_635_4 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_4 + var_635_0
					end
				end

				arg_632_1.text_.text = var_635_2
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_5 = math.max(var_635_1, arg_632_1.talkMaxDuration)

			if var_635_0 <= arg_632_1.time_ and arg_632_1.time_ < var_635_0 + var_635_5 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_0) / var_635_5

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_0 + var_635_5 and arg_632_1.time_ < var_635_0 + var_635_5 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1103404157 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1103404157
		arg_636_1.duration_ = 2.27

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1103404158(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0.25

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_1 = arg_636_1:GetWordFromCfg(1103404157)
				local var_639_2 = arg_636_1:FormatText(var_639_1.content)

				arg_636_1.text_.text = var_639_2

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_4 = 10 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_2) / 10)

				if (10 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_2) / 10)) > 0 and var_639_0 < var_639_4 then
					arg_636_1.talkMaxDuration = var_639_4

					if var_639_4 + 0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_4 + 0
					end
				end

				arg_636_1.text_.text = var_639_2
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb") ~= 0 then
					local var_639_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb") / 1000

					if var_639_5 + 0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_5 + 0
					end

					if var_639_1.prefab_name ~= "" and arg_636_1.actors_[var_639_1.prefab_name] ~= nil then
						local var_639_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_1.prefab_name].transform, "story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")

						arg_636_1:RecordAudio("1103404157", var_639_6)
						arg_636_1:RecordAudio("1103404157", var_639_6)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_7 = math.max(var_639_0, arg_636_1.talkMaxDuration)

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_7 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - 0) / var_639_7

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= 0 + var_639_7 and arg_636_1.time_ < 0 + var_639_7 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1103404158 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1103404158
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1103404159(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 and not isNil(arg_640_1.actors_["1034ui_story"]) and arg_640_1.var_.characterEffect1034ui_story == nil then
				arg_640_1.var_.characterEffect1034ui_story = arg_640_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_0 = 0.200000002980232

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_0 and not isNil(arg_640_1.actors_["1034ui_story"]) then
				if arg_640_1.var_.characterEffect1034ui_story and not isNil(arg_640_1.actors_["1034ui_story"]) then
					arg_640_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_640_1.time_ - 0) / var_643_0)
				end
			end

			if arg_640_1.time_ >= 0 + var_643_0 and arg_640_1.time_ < 0 + var_643_0 + arg_643_0 and not isNil(arg_640_1.actors_["1034ui_story"]) and arg_640_1.var_.characterEffect1034ui_story then
				arg_640_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_643_1 = arg_640_1.bgs_.R3401a.transform

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.var_.moveOldPosR3401a = var_643_1.localPosition
			end

			local var_643_2 = 1.98333333333333

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_2 then
				var_643_1.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPosR3401a, Vector3.New(0, 1, 9), (arg_640_1.time_ - 0) / var_643_2)
			end

			if arg_640_1.time_ >= 0 + var_643_2 and arg_640_1.time_ < 0 + var_643_2 + arg_643_0 then
				var_643_1.localPosition = Vector3.New(0, 1, 9)
			end

			local var_643_3 = 0

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_3 + arg_643_0 then
				arg_640_1.allBtn_.enabled = false
			end

			if arg_640_1.time_ >= var_643_3 + 1.98333333333333 and arg_640_1.time_ < var_643_3 + 1.98333333333333 + arg_643_0 then
				arg_640_1.allBtn_.enabled = true
			end

			local var_643_4 = 0
			local var_643_5 = 0.625

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_4 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				arg_640_1.leftNameTxt_.text = arg_640_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_6 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(1103404158).content)

				arg_640_1.text_.text = var_643_6

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_8 = 25 <= 0 and var_643_5 or var_643_5 * (utf8.len(var_643_6) / 25)

				if (25 <= 0 and var_643_5 or var_643_5 * (utf8.len(var_643_6) / 25)) > 0 and var_643_5 < var_643_8 then
					arg_640_1.talkMaxDuration = var_643_8

					if var_643_8 + var_643_4 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_8 + var_643_4
					end
				end

				arg_640_1.text_.text = var_643_6
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_9 = math.max(var_643_5, arg_640_1.talkMaxDuration)

			if var_643_4 <= arg_640_1.time_ and arg_640_1.time_ < var_643_4 + var_643_9 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_4) / var_643_9

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_4 + var_643_9 and arg_640_1.time_ < var_643_4 + var_643_9 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.98333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play1103404159 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1103404159
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1103404160(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0.4

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				arg_644_1.leftNameTxt_.text = arg_644_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, true)
				arg_644_1.iconController_:SetSelectedState("hero")

				arg_644_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_644_1.callingController_:SetSelectedState("normal")

				arg_644_1.keyicon_.color = Color.New(1, 1, 1)
				arg_644_1.icon_.color = Color.New(1, 1, 1)

				local var_647_1 = arg_644_1:FormatText(arg_644_1:GetWordFromCfg(1103404159).content)

				arg_644_1.text_.text = var_647_1

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_3 = 16 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 16)

				if (16 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 16)) > 0 and var_647_0 < var_647_3 then
					arg_644_1.talkMaxDuration = var_647_3

					if var_647_3 + 0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_3 + 0
					end
				end

				arg_644_1.text_.text = var_647_1
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_4 = math.max(var_647_0, arg_644_1.talkMaxDuration)

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_4 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - 0) / var_647_4

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= 0 + var_647_4 and arg_644_1.time_ < 0 + var_647_4 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play1103404160 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1103404160
		arg_648_1.duration_ = 5.27

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1103404161(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1.var_.moveOldPosR3401a = arg_648_1.bgs_.R3401a.transform.localPosition
			end

			local var_651_0 = 0.333333333333333

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_0 then
				arg_648_1.bgs_.R3401a.transform.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPosR3401a, Vector3.New(0, 1, 10), (arg_648_1.time_ - 0) / var_651_0)
			end

			if arg_648_1.time_ >= 0 + var_651_0 and arg_648_1.time_ < 0 + var_651_0 + arg_651_0 then
				arg_648_1.bgs_.R3401a.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_651_1 = 0
			local var_651_2 = 0.5

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				arg_648_1.leftNameTxt_.text = arg_648_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_3 = arg_648_1:GetWordFromCfg(1103404160)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_6 = 20 <= 0 and var_651_2 or var_651_2 * (utf8.len(var_651_4) / 20)

				if (20 <= 0 and var_651_2 or var_651_2 * (utf8.len(var_651_4) / 20)) > 0 and var_651_2 < var_651_6 then
					arg_648_1.talkMaxDuration = var_651_6

					if var_651_6 + var_651_1 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_6 + var_651_1
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb") ~= 0 then
					local var_651_7 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb") / 1000

					if var_651_7 + var_651_1 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_1
					end

					if var_651_3.prefab_name ~= "" and arg_648_1.actors_[var_651_3.prefab_name] ~= nil then
						local var_651_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_3.prefab_name].transform, "story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")

						arg_648_1:RecordAudio("1103404160", var_651_8)
						arg_648_1:RecordAudio("1103404160", var_651_8)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_9 = math.max(var_651_2, arg_648_1.talkMaxDuration)

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_9 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_1) / var_651_9

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_1 + var_651_9 and arg_648_1.time_ < var_651_1 + var_651_9 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R3401a",
				frequency = 50,
				className = "StoryShakeNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0.1)
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_648_1:InitPlayNodeList()
	end,
	Play1103404161 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1103404161
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1103404162(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 and not isNil(arg_652_1.actors_["1034ui_story"]) and arg_652_1.var_.characterEffect1034ui_story == nil then
				arg_652_1.var_.characterEffect1034ui_story = arg_652_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_0 = 0.200000002980232

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_0 and not isNil(arg_652_1.actors_["1034ui_story"]) then
				if arg_652_1.var_.characterEffect1034ui_story and not isNil(arg_652_1.actors_["1034ui_story"]) then
					arg_652_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_652_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_652_1.time_ - 0) / var_655_0)
				end
			end

			if arg_652_1.time_ >= 0 + var_655_0 and arg_652_1.time_ < 0 + var_655_0 + arg_655_0 and not isNil(arg_652_1.actors_["1034ui_story"]) and arg_652_1.var_.characterEffect1034ui_story then
				arg_652_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_652_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_655_1 = 0
			local var_655_2 = 1.3

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_3 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(1103404161).content)

				arg_652_1.text_.text = var_655_3

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_5 = 52 <= 0 and var_655_2 or var_655_2 * (utf8.len(var_655_3) / 52)

				if (52 <= 0 and var_655_2 or var_655_2 * (utf8.len(var_655_3) / 52)) > 0 and var_655_2 < var_655_5 then
					arg_652_1.talkMaxDuration = var_655_5

					if var_655_5 + var_655_1 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_5 + var_655_1
					end
				end

				arg_652_1.text_.text = var_655_3
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_6 = math.max(var_655_2, arg_652_1.talkMaxDuration)

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_6 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_1) / var_655_6

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_1 + var_655_6 and arg_652_1.time_ < var_655_1 + var_655_6 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1103404162 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1103404162
		arg_656_1.duration_ = 5.07

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1103404163(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0.45

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_1 = arg_656_1:GetWordFromCfg(1103404162)
				local var_659_2 = arg_656_1:FormatText(var_659_1.content)

				arg_656_1.text_.text = var_659_2

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_4 = 18 <= 0 and var_659_0 or var_659_0 * (utf8.len(var_659_2) / 18)

				if (18 <= 0 and var_659_0 or var_659_0 * (utf8.len(var_659_2) / 18)) > 0 and var_659_0 < var_659_4 then
					arg_656_1.talkMaxDuration = var_659_4

					if var_659_4 + 0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_4 + 0
					end
				end

				arg_656_1.text_.text = var_659_2
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb") ~= 0 then
					local var_659_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb") / 1000

					if var_659_5 + 0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_5 + 0
					end

					if var_659_1.prefab_name ~= "" and arg_656_1.actors_[var_659_1.prefab_name] ~= nil then
						local var_659_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_1.prefab_name].transform, "story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")

						arg_656_1:RecordAudio("1103404162", var_659_6)
						arg_656_1:RecordAudio("1103404162", var_659_6)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_7 = math.max(var_659_0, arg_656_1.talkMaxDuration)

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_7 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - 0) / var_659_7

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= 0 + var_659_7 and arg_656_1.time_ < 0 + var_659_7 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play1103404163 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1103404163
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1103404164(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 and not isNil(arg_660_1.actors_["1034ui_story"]) and arg_660_1.var_.characterEffect1034ui_story == nil then
				arg_660_1.var_.characterEffect1034ui_story = arg_660_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_663_0 = 0.200000002980232

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_0 and not isNil(arg_660_1.actors_["1034ui_story"]) then
				if arg_660_1.var_.characterEffect1034ui_story and not isNil(arg_660_1.actors_["1034ui_story"]) then
					arg_660_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_660_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_660_1.time_ - 0) / var_663_0)
				end
			end

			if arg_660_1.time_ >= 0 + var_663_0 and arg_660_1.time_ < 0 + var_663_0 + arg_663_0 and not isNil(arg_660_1.actors_["1034ui_story"]) and arg_660_1.var_.characterEffect1034ui_story then
				arg_660_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_660_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_663_1 = 0
			local var_663_2 = 0.3

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_3 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(1103404163).content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 12 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 12)

				if (12 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 12)) > 0 and var_663_2 < var_663_5 then
					arg_660_1.talkMaxDuration = var_663_5

					if var_663_5 + var_663_1 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_5 + var_663_1
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_6 = math.max(var_663_2, arg_660_1.talkMaxDuration)

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_6 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_1) / var_663_6

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_1 + var_663_6 and arg_660_1.time_ < var_663_1 + var_663_6 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1103404164 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1103404164
		arg_664_1.duration_ = 5.27

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1103404165(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0.425

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				arg_664_1.leftNameTxt_.text = arg_664_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_1 = arg_664_1:GetWordFromCfg(1103404164)
				local var_667_2 = arg_664_1:FormatText(var_667_1.content)

				arg_664_1.text_.text = var_667_2

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_4 = 17 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_2) / 17)

				if (17 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_2) / 17)) > 0 and var_667_0 < var_667_4 then
					arg_664_1.talkMaxDuration = var_667_4

					if var_667_4 + 0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_4 + 0
					end
				end

				arg_664_1.text_.text = var_667_2
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb") ~= 0 then
					local var_667_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb") / 1000

					if var_667_5 + 0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_5 + 0
					end

					if var_667_1.prefab_name ~= "" and arg_664_1.actors_[var_667_1.prefab_name] ~= nil then
						local var_667_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_1.prefab_name].transform, "story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")

						arg_664_1:RecordAudio("1103404164", var_667_6)
						arg_664_1:RecordAudio("1103404164", var_667_6)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_7 = math.max(var_667_0, arg_664_1.talkMaxDuration)

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_7 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - 0) / var_667_7

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= 0 + var_667_7 and arg_664_1.time_ < 0 + var_667_7 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1103404165 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1103404165
		arg_668_1.duration_ = 8.37

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1103404166(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0.975

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_1 = arg_668_1:GetWordFromCfg(1103404165)
				local var_671_2 = arg_668_1:FormatText(var_671_1.content)

				arg_668_1.text_.text = var_671_2

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_4 = 39 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_2) / 39)

				if (39 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_2) / 39)) > 0 and var_671_0 < var_671_4 then
					arg_668_1.talkMaxDuration = var_671_4

					if var_671_4 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_4 + 0
					end
				end

				arg_668_1.text_.text = var_671_2
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb") ~= 0 then
					local var_671_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb") / 1000

					if var_671_5 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_5 + 0
					end

					if var_671_1.prefab_name ~= "" and arg_668_1.actors_[var_671_1.prefab_name] ~= nil then
						local var_671_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_1.prefab_name].transform, "story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")

						arg_668_1:RecordAudio("1103404165", var_671_6)
						arg_668_1:RecordAudio("1103404165", var_671_6)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")
				end

				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_7 = math.max(var_671_0, arg_668_1.talkMaxDuration)

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_7 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - 0) / var_671_7

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= 0 + var_671_7 and arg_668_1.time_ < 0 + var_671_7 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1103404166 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1103404166
		arg_672_1.duration_ = 9.8

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1103404167(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0.975

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_1 = arg_672_1:GetWordFromCfg(1103404166)
				local var_675_2 = arg_672_1:FormatText(var_675_1.content)

				arg_672_1.text_.text = var_675_2

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_4 = 39 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_2) / 39)

				if (39 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_2) / 39)) > 0 and var_675_0 < var_675_4 then
					arg_672_1.talkMaxDuration = var_675_4

					if var_675_4 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_4 + 0
					end
				end

				arg_672_1.text_.text = var_675_2
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb") ~= 0 then
					local var_675_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb") / 1000

					if var_675_5 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_5 + 0
					end

					if var_675_1.prefab_name ~= "" and arg_672_1.actors_[var_675_1.prefab_name] ~= nil then
						local var_675_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_1.prefab_name].transform, "story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")

						arg_672_1:RecordAudio("1103404166", var_675_6)
						arg_672_1:RecordAudio("1103404166", var_675_6)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_7 = math.max(var_675_0, arg_672_1.talkMaxDuration)

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_7 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - 0) / var_675_7

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= 0 + var_675_7 and arg_672_1.time_ < 0 + var_675_7 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1103404167 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1103404167
		arg_676_1.duration_ = 1

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"

			SetActive(arg_676_1.choicesGo_, true)

			for iter_677_0, iter_677_1 in ipairs(arg_676_1.choices_) do
				SetActive(iter_677_1.go, iter_677_0 <= 2)
			end

			arg_676_1.choices_[1].txt.text = arg_676_1:FormatText(StoryChoiceCfg[1464].name)
			arg_676_1.choices_[2].txt.text = arg_676_1:FormatText(StoryChoiceCfg[1465].name)
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1103404168(arg_676_1)
			end

			if arg_678_0 == 2 then
				arg_676_0:Play1103404170(arg_676_1)
			end

			arg_676_1:RecordChoiceLog(1103404167, 1464, 1465)
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 and not isNil(arg_676_1.actors_["1034ui_story"]) and arg_676_1.var_.characterEffect1034ui_story == nil then
				arg_676_1.var_.characterEffect1034ui_story = arg_676_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_0 = 0.200000002980232

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_0 and not isNil(arg_676_1.actors_["1034ui_story"]) then
				if arg_676_1.var_.characterEffect1034ui_story and not isNil(arg_676_1.actors_["1034ui_story"]) then
					arg_676_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_676_1.time_ - 0) / var_679_0)
				end
			end

			if arg_676_1.time_ >= 0 + var_679_0 and arg_676_1.time_ < 0 + var_679_0 + arg_679_0 and not isNil(arg_676_1.actors_["1034ui_story"]) and arg_676_1.var_.characterEffect1034ui_story then
				arg_676_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_679_1 = 0

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_1 + arg_679_0 then
				arg_676_1.allBtn_.enabled = false
			end

			if arg_676_1.time_ >= var_679_1 + 1 and arg_676_1.time_ < var_679_1 + 1 + arg_679_0 then
				arg_676_1.allBtn_.enabled = true
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1103404168 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1103404168
		arg_680_1.duration_ = 2.33

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1103404169(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 and not isNil(arg_680_1.actors_["1034ui_story"]) and arg_680_1.var_.characterEffect1034ui_story == nil then
				arg_680_1.var_.characterEffect1034ui_story = arg_680_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_0 = 0.200000002980232

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_0 and not isNil(arg_680_1.actors_["1034ui_story"]) then
				if arg_680_1.var_.characterEffect1034ui_story and not isNil(arg_680_1.actors_["1034ui_story"]) then
					arg_680_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= 0 + var_683_0 and arg_680_1.time_ < 0 + var_683_0 + arg_683_0 and not isNil(arg_680_1.actors_["1034ui_story"]) and arg_680_1.var_.characterEffect1034ui_story then
				arg_680_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_683_2 = 0
			local var_683_3 = 0.275

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_2 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				arg_680_1.leftNameTxt_.text = arg_680_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_4 = arg_680_1:GetWordFromCfg(1103404168)
				local var_683_5 = arg_680_1:FormatText(var_683_4.content)

				arg_680_1.text_.text = var_683_5

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_7 = 11 <= 0 and var_683_3 or var_683_3 * (utf8.len(var_683_5) / 11)

				if (11 <= 0 and var_683_3 or var_683_3 * (utf8.len(var_683_5) / 11)) > 0 and var_683_3 < var_683_7 then
					arg_680_1.talkMaxDuration = var_683_7

					if var_683_7 + var_683_2 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_7 + var_683_2
					end
				end

				arg_680_1.text_.text = var_683_5
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb") ~= 0 then
					local var_683_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb") / 1000

					if var_683_8 + var_683_2 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_8 + var_683_2
					end

					if var_683_4.prefab_name ~= "" and arg_680_1.actors_[var_683_4.prefab_name] ~= nil then
						local var_683_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_4.prefab_name].transform, "story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")

						arg_680_1:RecordAudio("1103404168", var_683_9)
						arg_680_1:RecordAudio("1103404168", var_683_9)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_10 = math.max(var_683_3, arg_680_1.talkMaxDuration)

			if var_683_2 <= arg_680_1.time_ and arg_680_1.time_ < var_683_2 + var_683_10 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_2) / var_683_10

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_2 + var_683_10 and arg_680_1.time_ < var_683_2 + var_683_10 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1103404169 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1103404169
		arg_684_1.duration_ = 5.13

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1103404172(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0.6

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= 0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, true)

				arg_684_1.leftNameTxt_.text = arg_684_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_1 = arg_684_1:GetWordFromCfg(1103404169)
				local var_687_2 = arg_684_1:FormatText(var_687_1.content)

				arg_684_1.text_.text = var_687_2

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_4 = 24 <= 0 and var_687_0 or var_687_0 * (utf8.len(var_687_2) / 24)

				if (24 <= 0 and var_687_0 or var_687_0 * (utf8.len(var_687_2) / 24)) > 0 and var_687_0 < var_687_4 then
					arg_684_1.talkMaxDuration = var_687_4

					if var_687_4 + 0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_4 + 0
					end
				end

				arg_684_1.text_.text = var_687_2
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb") ~= 0 then
					local var_687_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb") / 1000

					if var_687_5 + 0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_5 + 0
					end

					if var_687_1.prefab_name ~= "" and arg_684_1.actors_[var_687_1.prefab_name] ~= nil then
						local var_687_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_1.prefab_name].transform, "story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")

						arg_684_1:RecordAudio("1103404169", var_687_6)
						arg_684_1:RecordAudio("1103404169", var_687_6)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_7 = math.max(var_687_0, arg_684_1.talkMaxDuration)

			if 0 <= arg_684_1.time_ and arg_684_1.time_ < 0 + var_687_7 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - 0) / var_687_7

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= 0 + var_687_7 and arg_684_1.time_ < 0 + var_687_7 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1103404172 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1103404172
		arg_688_1.duration_ = 5

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1103404173(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 and not isNil(arg_688_1.actors_["1034ui_story"]) and arg_688_1.var_.characterEffect1034ui_story == nil then
				arg_688_1.var_.characterEffect1034ui_story = arg_688_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_691_0 = 0.200000002980232

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_0 and not isNil(arg_688_1.actors_["1034ui_story"]) then
				if arg_688_1.var_.characterEffect1034ui_story and not isNil(arg_688_1.actors_["1034ui_story"]) then
					arg_688_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_688_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_688_1.time_ - 0) / var_691_0)
				end
			end

			if arg_688_1.time_ >= 0 + var_691_0 and arg_688_1.time_ < 0 + var_691_0 + arg_691_0 and not isNil(arg_688_1.actors_["1034ui_story"]) and arg_688_1.var_.characterEffect1034ui_story then
				arg_688_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_688_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_691_1 = 0
			local var_691_2 = 0.375

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_1 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				arg_688_1.leftNameTxt_.text = arg_688_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, true)
				arg_688_1.iconController_:SetSelectedState("hero")

				arg_688_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_688_1.callingController_:SetSelectedState("normal")

				arg_688_1.keyicon_.color = Color.New(1, 1, 1)
				arg_688_1.icon_.color = Color.New(1, 1, 1)

				local var_691_3 = arg_688_1:FormatText(arg_688_1:GetWordFromCfg(1103404172).content)

				arg_688_1.text_.text = var_691_3

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_5 = 15 <= 0 and var_691_2 or var_691_2 * (utf8.len(var_691_3) / 15)

				if (15 <= 0 and var_691_2 or var_691_2 * (utf8.len(var_691_3) / 15)) > 0 and var_691_2 < var_691_5 then
					arg_688_1.talkMaxDuration = var_691_5

					if var_691_5 + var_691_1 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_5 + var_691_1
					end
				end

				arg_688_1.text_.text = var_691_3
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)
				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_6 = math.max(var_691_2, arg_688_1.talkMaxDuration)

			if var_691_1 <= arg_688_1.time_ and arg_688_1.time_ < var_691_1 + var_691_6 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_1) / var_691_6

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_1 + var_691_6 and arg_688_1.time_ < var_691_1 + var_691_6 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1103404173 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1103404173
		arg_692_1.duration_ = 1.73

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play1103404174(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 and not isNil(arg_692_1.actors_["1034ui_story"]) and arg_692_1.var_.characterEffect1034ui_story == nil then
				arg_692_1.var_.characterEffect1034ui_story = arg_692_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_695_0 = 0.200000002980232

			if 0 <= arg_692_1.time_ and arg_692_1.time_ < 0 + var_695_0 and not isNil(arg_692_1.actors_["1034ui_story"]) then
				if arg_692_1.var_.characterEffect1034ui_story and not isNil(arg_692_1.actors_["1034ui_story"]) then
					arg_692_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_692_1.time_ >= 0 + var_695_0 and arg_692_1.time_ < 0 + var_695_0 + arg_695_0 and not isNil(arg_692_1.actors_["1034ui_story"]) and arg_692_1.var_.characterEffect1034ui_story then
				arg_692_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_695_2 = 0
			local var_695_3 = 0.125

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_2 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				arg_692_1.leftNameTxt_.text = arg_692_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_4 = arg_692_1:GetWordFromCfg(1103404173)
				local var_695_5 = arg_692_1:FormatText(var_695_4.content)

				arg_692_1.text_.text = var_695_5

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_7 = 5 <= 0 and var_695_3 or var_695_3 * (utf8.len(var_695_5) / 5)

				if (5 <= 0 and var_695_3 or var_695_3 * (utf8.len(var_695_5) / 5)) > 0 and var_695_3 < var_695_7 then
					arg_692_1.talkMaxDuration = var_695_7

					if var_695_7 + var_695_2 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_7 + var_695_2
					end
				end

				arg_692_1.text_.text = var_695_5
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb") ~= 0 then
					local var_695_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb") / 1000

					if var_695_8 + var_695_2 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_8 + var_695_2
					end

					if var_695_4.prefab_name ~= "" and arg_692_1.actors_[var_695_4.prefab_name] ~= nil then
						local var_695_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_4.prefab_name].transform, "story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")

						arg_692_1:RecordAudio("1103404173", var_695_9)
						arg_692_1:RecordAudio("1103404173", var_695_9)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_10 = math.max(var_695_3, arg_692_1.talkMaxDuration)

			if var_695_2 <= arg_692_1.time_ and arg_692_1.time_ < var_695_2 + var_695_10 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_2) / var_695_10

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_2 + var_695_10 and arg_692_1.time_ < var_695_2 + var_695_10 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play1103404174 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1103404174
		arg_696_1.duration_ = 5

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1103404175(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 and not isNil(arg_696_1.actors_["1034ui_story"]) and arg_696_1.var_.characterEffect1034ui_story == nil then
				arg_696_1.var_.characterEffect1034ui_story = arg_696_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_699_0 = 0.200000002980232

			if 0 <= arg_696_1.time_ and arg_696_1.time_ < 0 + var_699_0 and not isNil(arg_696_1.actors_["1034ui_story"]) then
				if arg_696_1.var_.characterEffect1034ui_story and not isNil(arg_696_1.actors_["1034ui_story"]) then
					arg_696_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_696_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_696_1.time_ - 0) / var_699_0)
				end
			end

			if arg_696_1.time_ >= 0 + var_699_0 and arg_696_1.time_ < 0 + var_699_0 + arg_699_0 and not isNil(arg_696_1.actors_["1034ui_story"]) and arg_696_1.var_.characterEffect1034ui_story then
				arg_696_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_696_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_699_1 = 0
			local var_699_2 = 1.2

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_1 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, false)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_3 = arg_696_1:FormatText(arg_696_1:GetWordFromCfg(1103404174).content)

				arg_696_1.text_.text = var_699_3

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_5 = 48 <= 0 and var_699_2 or var_699_2 * (utf8.len(var_699_3) / 48)

				if (48 <= 0 and var_699_2 or var_699_2 * (utf8.len(var_699_3) / 48)) > 0 and var_699_2 < var_699_5 then
					arg_696_1.talkMaxDuration = var_699_5

					if var_699_5 + var_699_1 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_5 + var_699_1
					end
				end

				arg_696_1.text_.text = var_699_3
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)
				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_6 = math.max(var_699_2, arg_696_1.talkMaxDuration)

			if var_699_1 <= arg_696_1.time_ and arg_696_1.time_ < var_699_1 + var_699_6 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_1) / var_699_6

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_1 + var_699_6 and arg_696_1.time_ < var_699_1 + var_699_6 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1103404175 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1103404175
		arg_700_1.duration_ = 13.03

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1103404176(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			if 0 < arg_700_1.time_ and arg_700_1.time_ <= 0 + arg_703_0 and not isNil(arg_700_1.actors_["1034ui_story"]) and arg_700_1.var_.characterEffect1034ui_story == nil then
				arg_700_1.var_.characterEffect1034ui_story = arg_700_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_703_0 = 0.200000002980232

			if 0 <= arg_700_1.time_ and arg_700_1.time_ < 0 + var_703_0 and not isNil(arg_700_1.actors_["1034ui_story"]) then
				if arg_700_1.var_.characterEffect1034ui_story and not isNil(arg_700_1.actors_["1034ui_story"]) then
					arg_700_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_700_1.time_ >= 0 + var_703_0 and arg_700_1.time_ < 0 + var_703_0 + arg_703_0 and not isNil(arg_700_1.actors_["1034ui_story"]) and arg_700_1.var_.characterEffect1034ui_story then
				arg_700_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_703_2 = 0
			local var_703_3 = 1.65

			if 0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_2 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, true)

				arg_700_1.leftNameTxt_.text = arg_700_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_700_1.leftNameTxt_.transform)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1.leftNameTxt_.text)
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_4 = arg_700_1:GetWordFromCfg(1103404175)
				local var_703_5 = arg_700_1:FormatText(var_703_4.content)

				arg_700_1.text_.text = var_703_5

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_7 = 66 <= 0 and var_703_3 or var_703_3 * (utf8.len(var_703_5) / 66)

				if (66 <= 0 and var_703_3 or var_703_3 * (utf8.len(var_703_5) / 66)) > 0 and var_703_3 < var_703_7 then
					arg_700_1.talkMaxDuration = var_703_7

					if var_703_7 + var_703_2 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_7 + var_703_2
					end
				end

				arg_700_1.text_.text = var_703_5
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb") ~= 0 then
					local var_703_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb") / 1000

					if var_703_8 + var_703_2 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_8 + var_703_2
					end

					if var_703_4.prefab_name ~= "" and arg_700_1.actors_[var_703_4.prefab_name] ~= nil then
						local var_703_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_700_1.actors_[var_703_4.prefab_name].transform, "story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")

						arg_700_1:RecordAudio("1103404175", var_703_9)
						arg_700_1:RecordAudio("1103404175", var_703_9)
					else
						arg_700_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")
					end

					arg_700_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")
				end

				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_10 = math.max(var_703_3, arg_700_1.talkMaxDuration)

			if var_703_2 <= arg_700_1.time_ and arg_700_1.time_ < var_703_2 + var_703_10 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - var_703_2) / var_703_10

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= var_703_2 + var_703_10 and arg_700_1.time_ < var_703_2 + var_703_10 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1103404176 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1103404176
		arg_704_1.duration_ = 11.93

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1103404177(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 1.175

			if 0 < arg_704_1.time_ and arg_704_1.time_ <= 0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, true)

				arg_704_1.leftNameTxt_.text = arg_704_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_704_1.leftNameTxt_.transform)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1.leftNameTxt_.text)
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_1 = arg_704_1:GetWordFromCfg(1103404176)
				local var_707_2 = arg_704_1:FormatText(var_707_1.content)

				arg_704_1.text_.text = var_707_2

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_4 = 47 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_2) / 47)

				if (47 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_2) / 47)) > 0 and var_707_0 < var_707_4 then
					arg_704_1.talkMaxDuration = var_707_4

					if var_707_4 + 0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_4 + 0
					end
				end

				arg_704_1.text_.text = var_707_2
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb") ~= 0 then
					local var_707_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb") / 1000

					if var_707_5 + 0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_5 + 0
					end

					if var_707_1.prefab_name ~= "" and arg_704_1.actors_[var_707_1.prefab_name] ~= nil then
						local var_707_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_704_1.actors_[var_707_1.prefab_name].transform, "story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")

						arg_704_1:RecordAudio("1103404176", var_707_6)
						arg_704_1:RecordAudio("1103404176", var_707_6)
					else
						arg_704_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")
					end

					arg_704_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")
				end

				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_7 = math.max(var_707_0, arg_704_1.talkMaxDuration)

			if 0 <= arg_704_1.time_ and arg_704_1.time_ < 0 + var_707_7 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - 0) / var_707_7

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= 0 + var_707_7 and arg_704_1.time_ < 0 + var_707_7 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1103404177 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1103404177
		arg_708_1.duration_ = 9.33

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1103404178(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 1

			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				arg_708_1.leftNameTxt_.text = arg_708_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_1 = arg_708_1:GetWordFromCfg(1103404177)
				local var_711_2 = arg_708_1:FormatText(var_711_1.content)

				arg_708_1.text_.text = var_711_2

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_4 = 40 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_2) / 40)

				if (40 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_2) / 40)) > 0 and var_711_0 < var_711_4 then
					arg_708_1.talkMaxDuration = var_711_4

					if var_711_4 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_4 + 0
					end
				end

				arg_708_1.text_.text = var_711_2
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb") ~= 0 then
					local var_711_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb") / 1000

					if var_711_5 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_5 + 0
					end

					if var_711_1.prefab_name ~= "" and arg_708_1.actors_[var_711_1.prefab_name] ~= nil then
						local var_711_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_1.prefab_name].transform, "story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")

						arg_708_1:RecordAudio("1103404177", var_711_6)
						arg_708_1:RecordAudio("1103404177", var_711_6)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_7 = math.max(var_711_0, arg_708_1.talkMaxDuration)

			if 0 <= arg_708_1.time_ and arg_708_1.time_ < 0 + var_711_7 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - 0) / var_711_7

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= 0 + var_711_7 and arg_708_1.time_ < 0 + var_711_7 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1103404178 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1103404178
		arg_712_1.duration_ = 7.67

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1103404179(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0.85

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				arg_712_1.leftNameTxt_.text = arg_712_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_1 = arg_712_1:GetWordFromCfg(1103404178)
				local var_715_2 = arg_712_1:FormatText(var_715_1.content)

				arg_712_1.text_.text = var_715_2

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_4 = 34 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_2) / 34)

				if (34 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_2) / 34)) > 0 and var_715_0 < var_715_4 then
					arg_712_1.talkMaxDuration = var_715_4

					if var_715_4 + 0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_4 + 0
					end
				end

				arg_712_1.text_.text = var_715_2
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb") ~= 0 then
					local var_715_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb") / 1000

					if var_715_5 + 0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_5 + 0
					end

					if var_715_1.prefab_name ~= "" and arg_712_1.actors_[var_715_1.prefab_name] ~= nil then
						local var_715_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_1.prefab_name].transform, "story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")

						arg_712_1:RecordAudio("1103404178", var_715_6)
						arg_712_1:RecordAudio("1103404178", var_715_6)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_7 = math.max(var_715_0, arg_712_1.talkMaxDuration)

			if 0 <= arg_712_1.time_ and arg_712_1.time_ < 0 + var_715_7 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - 0) / var_715_7

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= 0 + var_715_7 and arg_712_1.time_ < 0 + var_715_7 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1103404179 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1103404179
		arg_716_1.duration_ = 11.27

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1103404180(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0.9

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				arg_716_1.leftNameTxt_.text = arg_716_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_1 = arg_716_1:GetWordFromCfg(1103404179)
				local var_719_2 = arg_716_1:FormatText(var_719_1.content)

				arg_716_1.text_.text = var_719_2

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_4 = 36 <= 0 and var_719_0 or var_719_0 * (utf8.len(var_719_2) / 36)

				if (36 <= 0 and var_719_0 or var_719_0 * (utf8.len(var_719_2) / 36)) > 0 and var_719_0 < var_719_4 then
					arg_716_1.talkMaxDuration = var_719_4

					if var_719_4 + 0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_4 + 0
					end
				end

				arg_716_1.text_.text = var_719_2
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb") ~= 0 then
					local var_719_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb") / 1000

					if var_719_5 + 0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_5 + 0
					end

					if var_719_1.prefab_name ~= "" and arg_716_1.actors_[var_719_1.prefab_name] ~= nil then
						local var_719_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_716_1.actors_[var_719_1.prefab_name].transform, "story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")

						arg_716_1:RecordAudio("1103404179", var_719_6)
						arg_716_1:RecordAudio("1103404179", var_719_6)
					else
						arg_716_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")
					end

					arg_716_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")
				end

				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_7 = math.max(var_719_0, arg_716_1.talkMaxDuration)

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_7 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - 0) / var_719_7

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= 0 + var_719_7 and arg_716_1.time_ < 0 + var_719_7 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1103404180 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1103404180
		arg_720_1.duration_ = 5

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1103404181(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			if 1.05 < arg_720_1.time_ and arg_720_1.time_ <= 1.05 + arg_723_0 then
				local var_723_0 = arg_720_1.bgs_.R3401

				arg_720_1.bgs_.R3401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_723_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_723_1 = var_723_0:GetComponent("SpriteRenderer")

				if var_723_1 and var_723_1.sprite then
					local var_723_2 = 2 * (var_723_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_723_0.transform.localScale = Vector3.New(var_723_2 / var_723_1.sprite.bounds.size.y < var_723_2 * manager.ui.mainCameraCom_.aspect / var_723_1.sprite.bounds.size.x and var_723_2 * manager.ui.mainCameraCom_.aspect / var_723_1.sprite.bounds.size.x or var_723_2 / var_723_1.sprite.bounds.size.y, var_723_2 / var_723_1.sprite.bounds.size.y < var_723_2 * manager.ui.mainCameraCom_.aspect / var_723_1.sprite.bounds.size.x and var_723_2 * manager.ui.mainCameraCom_.aspect / var_723_1.sprite.bounds.size.x or var_723_2 / var_723_1.sprite.bounds.size.y, 0)
				end

				for iter_723_0, iter_723_1 in pairs(arg_720_1.bgs_) do
					if iter_723_0 ~= "R3401" then
						iter_723_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.06666666666667 < arg_720_1.time_ and arg_720_1.time_ <= 1.06666666666667 + arg_723_0 then
				local var_723_3 = arg_720_1.bgs_.R3401

				arg_720_1.bgs_.R3401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_723_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_723_4 = var_723_3:GetComponent("SpriteRenderer")

				if var_723_4 and var_723_4.sprite then
					local var_723_5 = 2 * (var_723_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_723_3.transform.localScale = Vector3.New(var_723_5 / var_723_4.sprite.bounds.size.y < var_723_5 * manager.ui.mainCameraCom_.aspect / var_723_4.sprite.bounds.size.x and var_723_5 * manager.ui.mainCameraCom_.aspect / var_723_4.sprite.bounds.size.x or var_723_5 / var_723_4.sprite.bounds.size.y, var_723_5 / var_723_4.sprite.bounds.size.y < var_723_5 * manager.ui.mainCameraCom_.aspect / var_723_4.sprite.bounds.size.x and var_723_5 * manager.ui.mainCameraCom_.aspect / var_723_4.sprite.bounds.size.x or var_723_5 / var_723_4.sprite.bounds.size.y, 0)
				end

				for iter_723_2, iter_723_3 in pairs(arg_720_1.bgs_) do
					if iter_723_2 ~= "R3401" then
						iter_723_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_723_6 = arg_720_1.actors_["1034ui_story"]

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 and not isNil(var_723_6) and arg_720_1.var_.characterEffect1034ui_story == nil then
				arg_720_1.var_.characterEffect1034ui_story = var_723_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_7 = 0.200000002980232

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_7 and not isNil(var_723_6) then
				if arg_720_1.var_.characterEffect1034ui_story and not isNil(var_723_6) then
					arg_720_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_720_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_720_1.time_ - 0) / var_723_7)
				end
			end

			if arg_720_1.time_ >= 0 + var_723_7 and arg_720_1.time_ < 0 + var_723_7 + arg_723_0 and not isNil(var_723_6) and arg_720_1.var_.characterEffect1034ui_story then
				arg_720_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_720_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action427")
			end

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_723_8 = 0

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_8 + arg_723_0 then
				arg_720_1.mask_.enabled = true
				arg_720_1.mask_.raycastTarget = true

				arg_720_1:SetGaussion(false)
			end

			local var_723_9 = 0.933333333333333

			if var_723_8 <= arg_720_1.time_ and arg_720_1.time_ < var_723_8 + var_723_9 then
				local var_723_10 = Color.New(0, 0, 0)

				var_723_10.a = Mathf.Lerp(0, 1, (arg_720_1.time_ - var_723_8) / var_723_9)
				arg_720_1.mask_.color = var_723_10
			end

			if arg_720_1.time_ >= var_723_8 + var_723_9 and arg_720_1.time_ < var_723_8 + var_723_9 + arg_723_0 then
				local var_723_11 = Color.New(0, 0, 0)

				var_723_11.a = 1
				arg_720_1.mask_.color = var_723_11
			end

			local var_723_12 = 1.06666666666667

			if 1.06666666666667 < arg_720_1.time_ and arg_720_1.time_ <= var_723_12 + arg_723_0 then
				arg_720_1.mask_.enabled = true
				arg_720_1.mask_.raycastTarget = true

				arg_720_1:SetGaussion(false)
			end

			local var_723_13 = 0.933333333333333

			if var_723_12 <= arg_720_1.time_ and arg_720_1.time_ < var_723_12 + var_723_13 then
				local var_723_14 = Color.New(0, 0, 0)

				var_723_14.a = Mathf.Lerp(1, 0, (arg_720_1.time_ - var_723_12) / var_723_13)
				arg_720_1.mask_.color = var_723_14
			end

			if arg_720_1.time_ >= var_723_12 + var_723_13 and arg_720_1.time_ < var_723_12 + var_723_13 + arg_723_0 then
				local var_723_15 = Color.New(0, 0, 0)

				arg_720_1.mask_.enabled = false
				var_723_15.a = 0
				arg_720_1.mask_.color = var_723_15
			end

			local var_723_16 = arg_720_1.bgs_.R3401a.transform

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401a = var_723_16.localPosition
			end

			local var_723_17 = 0.933333333333333

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_17 then
				var_723_16.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401a, Vector3.New(0, 1, 9.5), (arg_720_1.time_ - 0) / var_723_17)
			end

			if arg_720_1.time_ >= 0 + var_723_17 and arg_720_1.time_ < 0 + var_723_17 + arg_723_0 then
				var_723_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_723_18 = arg_720_1.bgs_.R3401.transform

			if 1.05 < arg_720_1.time_ and arg_720_1.time_ <= 1.05 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401 = var_723_18.localPosition
			end

			local var_723_19 = 0.001

			if 1.05 <= arg_720_1.time_ and arg_720_1.time_ < 1.05 + var_723_19 then
				var_723_18.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401, Vector3.New(0, 1, 8), (arg_720_1.time_ - 1.05) / var_723_19)
			end

			if arg_720_1.time_ >= 1.05 + var_723_19 and arg_720_1.time_ < 1.05 + var_723_19 + arg_723_0 then
				var_723_18.localPosition = Vector3.New(0, 1, 8)
			end

			local var_723_20 = arg_720_1.bgs_.R3401.transform

			if 1.06666666666667 < arg_720_1.time_ and arg_720_1.time_ <= 1.06666666666667 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401 = var_723_20.localPosition
			end

			local var_723_21 = 0.933333333333333

			if 1.06666666666667 <= arg_720_1.time_ and arg_720_1.time_ < 1.06666666666667 + var_723_21 then
				var_723_20.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401, Vector3.New(0, 1, 10), (arg_720_1.time_ - 1.06666666666667) / var_723_21)
			end

			if arg_720_1.time_ >= 1.06666666666667 + var_723_21 and arg_720_1.time_ < 1.06666666666667 + var_723_21 + arg_723_0 then
				var_723_20.localPosition = Vector3.New(0, 1, 10)
			end

			local var_723_22 = 0.533333333333333

			if 0.533333333333333 < arg_720_1.time_ and arg_720_1.time_ <= var_723_22 + arg_723_0 then
				arg_720_1.allBtn_.enabled = false
			end

			if arg_720_1.time_ >= var_723_22 + 1 and arg_720_1.time_ < var_723_22 + 1 + arg_723_0 then
				arg_720_1.allBtn_.enabled = true
			end

			local var_723_23 = 0
			local var_723_24 = 1.625

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_23 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, false)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_720_1.iconTrs_.gameObject, false)
				arg_720_1.callingController_:SetSelectedState("normal")

				local var_723_25 = arg_720_1:FormatText(arg_720_1:GetWordFromCfg(1103404180).content)

				arg_720_1.text_.text = var_723_25

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_27 = 65 <= 0 and var_723_24 or var_723_24 * (utf8.len(var_723_25) / 65)

				if (65 <= 0 and var_723_24 or var_723_24 * (utf8.len(var_723_25) / 65)) > 0 and var_723_24 < var_723_27 then
					arg_720_1.talkMaxDuration = var_723_27

					if var_723_27 + var_723_23 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_27 + var_723_23
					end
				end

				arg_720_1.text_.text = var_723_25
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)
				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_28 = math.max(var_723_24, arg_720_1.talkMaxDuration)

			if var_723_23 <= arg_720_1.time_ and arg_720_1.time_ < var_723_23 + var_723_28 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_23) / var_723_28

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_23 + var_723_28 and arg_720_1.time_ < var_723_23 + var_723_28 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.933333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666668,
				className = "StoryMoveNode",
				startTime = 1.05,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.933333333333333,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_720_1:InitPlayNodeList()
	end,
	Play1103404181 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1103404181
		arg_724_1.duration_ = 6.13

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1103404182(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 and not isNil(arg_724_1.actors_["1034ui_story"]) and arg_724_1.var_.characterEffect1034ui_story == nil then
				arg_724_1.var_.characterEffect1034ui_story = arg_724_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_727_0 = 0.200000002980232

			if 0 <= arg_724_1.time_ and arg_724_1.time_ < 0 + var_727_0 and not isNil(arg_724_1.actors_["1034ui_story"]) then
				if arg_724_1.var_.characterEffect1034ui_story and not isNil(arg_724_1.actors_["1034ui_story"]) then
					arg_724_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_724_1.time_ >= 0 + var_727_0 and arg_724_1.time_ < 0 + var_727_0 + arg_727_0 and not isNil(arg_724_1.actors_["1034ui_story"]) and arg_724_1.var_.characterEffect1034ui_story then
				arg_724_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_727_2 = 0
			local var_727_3 = 0.7

			if 0 < arg_724_1.time_ and arg_724_1.time_ <= var_727_2 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0
				arg_724_1.dialogCg_.alpha = 1

				arg_724_1.dialog_:SetActive(true)
				SetActive(arg_724_1.leftNameGo_, true)

				arg_724_1.leftNameTxt_.text = arg_724_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_724_1.leftNameTxt_.transform)

				arg_724_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_724_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_724_1:RecordName(arg_724_1.leftNameTxt_.text)
				SetActive(arg_724_1.iconTrs_.gameObject, false)
				arg_724_1.callingController_:SetSelectedState("normal")

				local var_727_4 = arg_724_1:GetWordFromCfg(1103404181)
				local var_727_5 = arg_724_1:FormatText(var_727_4.content)

				arg_724_1.text_.text = var_727_5

				LuaForUtil.ClearLinePrefixSymbol(arg_724_1.text_)

				local var_727_7 = 28 <= 0 and var_727_3 or var_727_3 * (utf8.len(var_727_5) / 28)

				if (28 <= 0 and var_727_3 or var_727_3 * (utf8.len(var_727_5) / 28)) > 0 and var_727_3 < var_727_7 then
					arg_724_1.talkMaxDuration = var_727_7

					if var_727_7 + var_727_2 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_7 + var_727_2
					end
				end

				arg_724_1.text_.text = var_727_5
				arg_724_1.typewritter.percent = 0

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb") ~= 0 then
					local var_727_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb") / 1000

					if var_727_8 + var_727_2 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_8 + var_727_2
					end

					if var_727_4.prefab_name ~= "" and arg_724_1.actors_[var_727_4.prefab_name] ~= nil then
						local var_727_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_724_1.actors_[var_727_4.prefab_name].transform, "story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")

						arg_724_1:RecordAudio("1103404181", var_727_9)
						arg_724_1:RecordAudio("1103404181", var_727_9)
					else
						arg_724_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")
					end

					arg_724_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")
				end

				arg_724_1:RecordContent(arg_724_1.text_.text)
			end

			local var_727_10 = math.max(var_727_3, arg_724_1.talkMaxDuration)

			if var_727_2 <= arg_724_1.time_ and arg_724_1.time_ < var_727_2 + var_727_10 then
				arg_724_1.typewritter.percent = (arg_724_1.time_ - var_727_2) / var_727_10

				arg_724_1.typewritter:SetDirty()
			end

			if arg_724_1.time_ >= var_727_2 + var_727_10 and arg_724_1.time_ < var_727_2 + var_727_10 + arg_727_0 then
				arg_724_1.typewritter.percent = 1

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(true)
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	Play1103404182 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1103404182
		arg_728_1.duration_ = 5

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1103404183(arg_728_1)
			end
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 and not isNil(arg_728_1.actors_["1034ui_story"]) and arg_728_1.var_.characterEffect1034ui_story == nil then
				arg_728_1.var_.characterEffect1034ui_story = arg_728_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_731_0 = 0.200000002980232

			if 0 <= arg_728_1.time_ and arg_728_1.time_ < 0 + var_731_0 and not isNil(arg_728_1.actors_["1034ui_story"]) then
				if arg_728_1.var_.characterEffect1034ui_story and not isNil(arg_728_1.actors_["1034ui_story"]) then
					arg_728_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_728_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_728_1.time_ - 0) / var_731_0)
				end
			end

			if arg_728_1.time_ >= 0 + var_731_0 and arg_728_1.time_ < 0 + var_731_0 + arg_731_0 and not isNil(arg_728_1.actors_["1034ui_story"]) and arg_728_1.var_.characterEffect1034ui_story then
				arg_728_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_728_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_731_1 = 0
			local var_731_2 = 0.275

			if 0 < arg_728_1.time_ and arg_728_1.time_ <= var_731_1 + arg_731_0 then
				arg_728_1.talkMaxDuration = 0
				arg_728_1.dialogCg_.alpha = 1

				arg_728_1.dialog_:SetActive(true)
				SetActive(arg_728_1.leftNameGo_, true)

				arg_728_1.leftNameTxt_.text = arg_728_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_728_1.leftNameTxt_.transform)

				arg_728_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_728_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_728_1:RecordName(arg_728_1.leftNameTxt_.text)
				SetActive(arg_728_1.iconTrs_.gameObject, true)
				arg_728_1.iconController_:SetSelectedState("hero")

				arg_728_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_728_1.callingController_:SetSelectedState("normal")

				arg_728_1.keyicon_.color = Color.New(1, 1, 1)
				arg_728_1.icon_.color = Color.New(1, 1, 1)

				local var_731_3 = arg_728_1:FormatText(arg_728_1:GetWordFromCfg(1103404182).content)

				arg_728_1.text_.text = var_731_3

				LuaForUtil.ClearLinePrefixSymbol(arg_728_1.text_)

				local var_731_5 = 11 <= 0 and var_731_2 or var_731_2 * (utf8.len(var_731_3) / 11)

				if (11 <= 0 and var_731_2 or var_731_2 * (utf8.len(var_731_3) / 11)) > 0 and var_731_2 < var_731_5 then
					arg_728_1.talkMaxDuration = var_731_5

					if var_731_5 + var_731_1 > arg_728_1.duration_ then
						arg_728_1.duration_ = var_731_5 + var_731_1
					end
				end

				arg_728_1.text_.text = var_731_3
				arg_728_1.typewritter.percent = 0

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(false)
				arg_728_1:RecordContent(arg_728_1.text_.text)
			end

			local var_731_6 = math.max(var_731_2, arg_728_1.talkMaxDuration)

			if var_731_1 <= arg_728_1.time_ and arg_728_1.time_ < var_731_1 + var_731_6 then
				arg_728_1.typewritter.percent = (arg_728_1.time_ - var_731_1) / var_731_6

				arg_728_1.typewritter:SetDirty()
			end

			if arg_728_1.time_ >= var_731_1 + var_731_6 and arg_728_1.time_ < var_731_1 + var_731_6 + arg_731_0 then
				arg_728_1.typewritter.percent = 1

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(true)
			end
		end

		arg_728_1.nodeConfigList_ = {}

		arg_728_1:InitPlayNodeList()
	end,
	Play1103404183 = function(arg_732_0, arg_732_1)
		arg_732_1.time_ = 0
		arg_732_1.frameCnt_ = 0
		arg_732_1.state_ = "playing"
		arg_732_1.curTalkId_ = 1103404183
		arg_732_1.duration_ = 5.03

		SetActive(arg_732_1.tipsGo_, false)

		function arg_732_1.onSingleLineFinish_()
			arg_732_1.onSingleLineUpdate_ = nil
			arg_732_1.onSingleLineFinish_ = nil
			arg_732_1.state_ = "waiting"
		end

		function arg_732_1.playNext_(arg_734_0)
			if arg_734_0 == 1 then
				arg_732_0:Play1103404184(arg_732_1)
			end
		end

		function arg_732_1.onSingleLineUpdate_(arg_735_0)
			if 0 < arg_732_1.time_ and arg_732_1.time_ <= 0 + arg_735_0 and not isNil(arg_732_1.actors_["1034ui_story"]) and arg_732_1.var_.characterEffect1034ui_story == nil then
				arg_732_1.var_.characterEffect1034ui_story = arg_732_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_735_0 = 0.200000002980232

			if 0 <= arg_732_1.time_ and arg_732_1.time_ < 0 + var_735_0 and not isNil(arg_732_1.actors_["1034ui_story"]) then
				if arg_732_1.var_.characterEffect1034ui_story and not isNil(arg_732_1.actors_["1034ui_story"]) then
					arg_732_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_732_1.time_ >= 0 + var_735_0 and arg_732_1.time_ < 0 + var_735_0 + arg_735_0 and not isNil(arg_732_1.actors_["1034ui_story"]) and arg_732_1.var_.characterEffect1034ui_story then
				arg_732_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_735_2 = 0
			local var_735_3 = 0.475

			if 0 < arg_732_1.time_ and arg_732_1.time_ <= var_735_2 + arg_735_0 then
				arg_732_1.talkMaxDuration = 0
				arg_732_1.dialogCg_.alpha = 1

				arg_732_1.dialog_:SetActive(true)
				SetActive(arg_732_1.leftNameGo_, true)

				arg_732_1.leftNameTxt_.text = arg_732_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_732_1.leftNameTxt_.transform)

				arg_732_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_732_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_732_1:RecordName(arg_732_1.leftNameTxt_.text)
				SetActive(arg_732_1.iconTrs_.gameObject, false)
				arg_732_1.callingController_:SetSelectedState("normal")

				local var_735_4 = arg_732_1:GetWordFromCfg(1103404183)
				local var_735_5 = arg_732_1:FormatText(var_735_4.content)

				arg_732_1.text_.text = var_735_5

				LuaForUtil.ClearLinePrefixSymbol(arg_732_1.text_)

				local var_735_7 = 19 <= 0 and var_735_3 or var_735_3 * (utf8.len(var_735_5) / 19)

				if (19 <= 0 and var_735_3 or var_735_3 * (utf8.len(var_735_5) / 19)) > 0 and var_735_3 < var_735_7 then
					arg_732_1.talkMaxDuration = var_735_7

					if var_735_7 + var_735_2 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_7 + var_735_2
					end
				end

				arg_732_1.text_.text = var_735_5
				arg_732_1.typewritter.percent = 0

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb") ~= 0 then
					local var_735_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb") / 1000

					if var_735_8 + var_735_2 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_8 + var_735_2
					end

					if var_735_4.prefab_name ~= "" and arg_732_1.actors_[var_735_4.prefab_name] ~= nil then
						local var_735_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_732_1.actors_[var_735_4.prefab_name].transform, "story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")

						arg_732_1:RecordAudio("1103404183", var_735_9)
						arg_732_1:RecordAudio("1103404183", var_735_9)
					else
						arg_732_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")
					end

					arg_732_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")
				end

				arg_732_1:RecordContent(arg_732_1.text_.text)
			end

			local var_735_10 = math.max(var_735_3, arg_732_1.talkMaxDuration)

			if var_735_2 <= arg_732_1.time_ and arg_732_1.time_ < var_735_2 + var_735_10 then
				arg_732_1.typewritter.percent = (arg_732_1.time_ - var_735_2) / var_735_10

				arg_732_1.typewritter:SetDirty()
			end

			if arg_732_1.time_ >= var_735_2 + var_735_10 and arg_732_1.time_ < var_735_2 + var_735_10 + arg_735_0 then
				arg_732_1.typewritter.percent = 1

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(true)
			end
		end

		arg_732_1.nodeConfigList_ = {}

		arg_732_1:InitPlayNodeList()
	end,
	Play1103404184 = function(arg_736_0, arg_736_1)
		arg_736_1.time_ = 0
		arg_736_1.frameCnt_ = 0
		arg_736_1.state_ = "playing"
		arg_736_1.curTalkId_ = 1103404184
		arg_736_1.duration_ = 5.13

		SetActive(arg_736_1.tipsGo_, false)

		function arg_736_1.onSingleLineFinish_()
			arg_736_1.onSingleLineUpdate_ = nil
			arg_736_1.onSingleLineFinish_ = nil
			arg_736_1.state_ = "waiting"
		end

		function arg_736_1.playNext_(arg_738_0)
			if arg_738_0 == 1 then
				arg_736_0:Play1103404185(arg_736_1)
			end
		end

		function arg_736_1.onSingleLineUpdate_(arg_739_0)
			local var_739_0 = 0.475

			if 0 < arg_736_1.time_ and arg_736_1.time_ <= 0 + arg_739_0 then
				arg_736_1.talkMaxDuration = 0
				arg_736_1.dialogCg_.alpha = 1

				arg_736_1.dialog_:SetActive(true)
				SetActive(arg_736_1.leftNameGo_, true)

				arg_736_1.leftNameTxt_.text = arg_736_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_736_1.leftNameTxt_.transform)

				arg_736_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_736_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_736_1:RecordName(arg_736_1.leftNameTxt_.text)
				SetActive(arg_736_1.iconTrs_.gameObject, false)
				arg_736_1.callingController_:SetSelectedState("normal")

				local var_739_1 = arg_736_1:GetWordFromCfg(1103404184)
				local var_739_2 = arg_736_1:FormatText(var_739_1.content)

				arg_736_1.text_.text = var_739_2

				LuaForUtil.ClearLinePrefixSymbol(arg_736_1.text_)

				local var_739_4 = 19 <= 0 and var_739_0 or var_739_0 * (utf8.len(var_739_2) / 19)

				if (19 <= 0 and var_739_0 or var_739_0 * (utf8.len(var_739_2) / 19)) > 0 and var_739_0 < var_739_4 then
					arg_736_1.talkMaxDuration = var_739_4

					if var_739_4 + 0 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_4 + 0
					end
				end

				arg_736_1.text_.text = var_739_2
				arg_736_1.typewritter.percent = 0

				arg_736_1.typewritter:SetDirty()
				arg_736_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb") ~= 0 then
					local var_739_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb") / 1000

					if var_739_5 + 0 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_5 + 0
					end

					if var_739_1.prefab_name ~= "" and arg_736_1.actors_[var_739_1.prefab_name] ~= nil then
						local var_739_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_736_1.actors_[var_739_1.prefab_name].transform, "story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")

						arg_736_1:RecordAudio("1103404184", var_739_6)
						arg_736_1:RecordAudio("1103404184", var_739_6)
					else
						arg_736_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")
					end

					arg_736_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")
				end

				arg_736_1:RecordContent(arg_736_1.text_.text)
			end

			local var_739_7 = math.max(var_739_0, arg_736_1.talkMaxDuration)

			if 0 <= arg_736_1.time_ and arg_736_1.time_ < 0 + var_739_7 then
				arg_736_1.typewritter.percent = (arg_736_1.time_ - 0) / var_739_7

				arg_736_1.typewritter:SetDirty()
			end

			if arg_736_1.time_ >= 0 + var_739_7 and arg_736_1.time_ < 0 + var_739_7 + arg_739_0 then
				arg_736_1.typewritter.percent = 1

				arg_736_1.typewritter:SetDirty()
				arg_736_1:ShowNextGo(true)
			end
		end

		arg_736_1.nodeConfigList_ = {}

		arg_736_1:InitPlayNodeList()
	end,
	Play1103404185 = function(arg_740_0, arg_740_1)
		arg_740_1.time_ = 0
		arg_740_1.frameCnt_ = 0
		arg_740_1.state_ = "playing"
		arg_740_1.curTalkId_ = 1103404185
		arg_740_1.duration_ = 4.67

		SetActive(arg_740_1.tipsGo_, false)

		function arg_740_1.onSingleLineFinish_()
			arg_740_1.onSingleLineUpdate_ = nil
			arg_740_1.onSingleLineFinish_ = nil
			arg_740_1.state_ = "waiting"
		end

		function arg_740_1.playNext_(arg_742_0)
			if arg_742_0 == 1 then
				arg_740_0:Play1103404186(arg_740_1)
			end
		end

		function arg_740_1.onSingleLineUpdate_(arg_743_0)
			local var_743_0 = 0.55

			if 0 < arg_740_1.time_ and arg_740_1.time_ <= 0 + arg_743_0 then
				arg_740_1.talkMaxDuration = 0
				arg_740_1.dialogCg_.alpha = 1

				arg_740_1.dialog_:SetActive(true)
				SetActive(arg_740_1.leftNameGo_, true)

				arg_740_1.leftNameTxt_.text = arg_740_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_740_1.leftNameTxt_.transform)

				arg_740_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_740_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_740_1:RecordName(arg_740_1.leftNameTxt_.text)
				SetActive(arg_740_1.iconTrs_.gameObject, false)
				arg_740_1.callingController_:SetSelectedState("normal")

				local var_743_1 = arg_740_1:GetWordFromCfg(1103404185)
				local var_743_2 = arg_740_1:FormatText(var_743_1.content)

				arg_740_1.text_.text = var_743_2

				LuaForUtil.ClearLinePrefixSymbol(arg_740_1.text_)

				local var_743_4 = 22 <= 0 and var_743_0 or var_743_0 * (utf8.len(var_743_2) / 22)

				if (22 <= 0 and var_743_0 or var_743_0 * (utf8.len(var_743_2) / 22)) > 0 and var_743_0 < var_743_4 then
					arg_740_1.talkMaxDuration = var_743_4

					if var_743_4 + 0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_4 + 0
					end
				end

				arg_740_1.text_.text = var_743_2
				arg_740_1.typewritter.percent = 0

				arg_740_1.typewritter:SetDirty()
				arg_740_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb") ~= 0 then
					local var_743_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb") / 1000

					if var_743_5 + 0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_5 + 0
					end

					if var_743_1.prefab_name ~= "" and arg_740_1.actors_[var_743_1.prefab_name] ~= nil then
						local var_743_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_740_1.actors_[var_743_1.prefab_name].transform, "story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")

						arg_740_1:RecordAudio("1103404185", var_743_6)
						arg_740_1:RecordAudio("1103404185", var_743_6)
					else
						arg_740_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")
					end

					arg_740_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")
				end

				arg_740_1:RecordContent(arg_740_1.text_.text)
			end

			local var_743_7 = math.max(var_743_0, arg_740_1.talkMaxDuration)

			if 0 <= arg_740_1.time_ and arg_740_1.time_ < 0 + var_743_7 then
				arg_740_1.typewritter.percent = (arg_740_1.time_ - 0) / var_743_7

				arg_740_1.typewritter:SetDirty()
			end

			if arg_740_1.time_ >= 0 + var_743_7 and arg_740_1.time_ < 0 + var_743_7 + arg_743_0 then
				arg_740_1.typewritter.percent = 1

				arg_740_1.typewritter:SetDirty()
				arg_740_1:ShowNextGo(true)
			end
		end

		arg_740_1.nodeConfigList_ = {}

		arg_740_1:InitPlayNodeList()
	end,
	Play1103404186 = function(arg_744_0, arg_744_1)
		arg_744_1.time_ = 0
		arg_744_1.frameCnt_ = 0
		arg_744_1.state_ = "playing"
		arg_744_1.curTalkId_ = 1103404186
		arg_744_1.duration_ = 5

		SetActive(arg_744_1.tipsGo_, false)

		function arg_744_1.onSingleLineFinish_()
			arg_744_1.onSingleLineUpdate_ = nil
			arg_744_1.onSingleLineFinish_ = nil
			arg_744_1.state_ = "waiting"
		end

		function arg_744_1.playNext_(arg_746_0)
			if arg_746_0 == 1 then
				arg_744_0:Play1103404187(arg_744_1)
			end
		end

		function arg_744_1.onSingleLineUpdate_(arg_747_0)
			if 0 < arg_744_1.time_ and arg_744_1.time_ <= 0 + arg_747_0 and not isNil(arg_744_1.actors_["1034ui_story"]) and arg_744_1.var_.characterEffect1034ui_story == nil then
				arg_744_1.var_.characterEffect1034ui_story = arg_744_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_747_0 = 0.200000002980232

			if 0 <= arg_744_1.time_ and arg_744_1.time_ < 0 + var_747_0 and not isNil(arg_744_1.actors_["1034ui_story"]) then
				if arg_744_1.var_.characterEffect1034ui_story and not isNil(arg_744_1.actors_["1034ui_story"]) then
					arg_744_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_744_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_744_1.time_ - 0) / var_747_0)
				end
			end

			if arg_744_1.time_ >= 0 + var_747_0 and arg_744_1.time_ < 0 + var_747_0 + arg_747_0 and not isNil(arg_744_1.actors_["1034ui_story"]) and arg_744_1.var_.characterEffect1034ui_story then
				arg_744_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_744_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_747_1 = 0
			local var_747_2 = 0.475

			if 0 < arg_744_1.time_ and arg_744_1.time_ <= var_747_1 + arg_747_0 then
				arg_744_1.talkMaxDuration = 0
				arg_744_1.dialogCg_.alpha = 1

				arg_744_1.dialog_:SetActive(true)
				SetActive(arg_744_1.leftNameGo_, true)

				arg_744_1.leftNameTxt_.text = arg_744_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_744_1.leftNameTxt_.transform)

				arg_744_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_744_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_744_1:RecordName(arg_744_1.leftNameTxt_.text)
				SetActive(arg_744_1.iconTrs_.gameObject, true)
				arg_744_1.iconController_:SetSelectedState("hero")

				arg_744_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_744_1.callingController_:SetSelectedState("normal")

				arg_744_1.keyicon_.color = Color.New(1, 1, 1)
				arg_744_1.icon_.color = Color.New(1, 1, 1)

				local var_747_3 = arg_744_1:FormatText(arg_744_1:GetWordFromCfg(1103404186).content)

				arg_744_1.text_.text = var_747_3

				LuaForUtil.ClearLinePrefixSymbol(arg_744_1.text_)

				local var_747_5 = 19 <= 0 and var_747_2 or var_747_2 * (utf8.len(var_747_3) / 19)

				if (19 <= 0 and var_747_2 or var_747_2 * (utf8.len(var_747_3) / 19)) > 0 and var_747_2 < var_747_5 then
					arg_744_1.talkMaxDuration = var_747_5

					if var_747_5 + var_747_1 > arg_744_1.duration_ then
						arg_744_1.duration_ = var_747_5 + var_747_1
					end
				end

				arg_744_1.text_.text = var_747_3
				arg_744_1.typewritter.percent = 0

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(false)
				arg_744_1:RecordContent(arg_744_1.text_.text)
			end

			local var_747_6 = math.max(var_747_2, arg_744_1.talkMaxDuration)

			if var_747_1 <= arg_744_1.time_ and arg_744_1.time_ < var_747_1 + var_747_6 then
				arg_744_1.typewritter.percent = (arg_744_1.time_ - var_747_1) / var_747_6

				arg_744_1.typewritter:SetDirty()
			end

			if arg_744_1.time_ >= var_747_1 + var_747_6 and arg_744_1.time_ < var_747_1 + var_747_6 + arg_747_0 then
				arg_744_1.typewritter.percent = 1

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(true)
			end
		end

		arg_744_1.nodeConfigList_ = {}

		arg_744_1:InitPlayNodeList()
	end,
	Play1103404187 = function(arg_748_0, arg_748_1)
		arg_748_1.time_ = 0
		arg_748_1.frameCnt_ = 0
		arg_748_1.state_ = "playing"
		arg_748_1.curTalkId_ = 1103404187
		arg_748_1.duration_ = 6.63

		SetActive(arg_748_1.tipsGo_, false)

		function arg_748_1.onSingleLineFinish_()
			arg_748_1.onSingleLineUpdate_ = nil
			arg_748_1.onSingleLineFinish_ = nil
			arg_748_1.state_ = "waiting"
		end

		function arg_748_1.playNext_(arg_750_0)
			if arg_750_0 == 1 then
				arg_748_0:Play1103404188(arg_748_1)
			end
		end

		function arg_748_1.onSingleLineUpdate_(arg_751_0)
			if 0 < arg_748_1.time_ and arg_748_1.time_ <= 0 + arg_751_0 and not isNil(arg_748_1.actors_["1034ui_story"]) and arg_748_1.var_.characterEffect1034ui_story == nil then
				arg_748_1.var_.characterEffect1034ui_story = arg_748_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_751_0 = 0.200000002980232

			if 0 <= arg_748_1.time_ and arg_748_1.time_ < 0 + var_751_0 and not isNil(arg_748_1.actors_["1034ui_story"]) then
				if arg_748_1.var_.characterEffect1034ui_story and not isNil(arg_748_1.actors_["1034ui_story"]) then
					arg_748_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_748_1.time_ >= 0 + var_751_0 and arg_748_1.time_ < 0 + var_751_0 + arg_751_0 and not isNil(arg_748_1.actors_["1034ui_story"]) and arg_748_1.var_.characterEffect1034ui_story then
				arg_748_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_751_2 = 0
			local var_751_3 = 0.725

			if 0 < arg_748_1.time_ and arg_748_1.time_ <= var_751_2 + arg_751_0 then
				arg_748_1.talkMaxDuration = 0
				arg_748_1.dialogCg_.alpha = 1

				arg_748_1.dialog_:SetActive(true)
				SetActive(arg_748_1.leftNameGo_, true)

				arg_748_1.leftNameTxt_.text = arg_748_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_748_1.leftNameTxt_.transform)

				arg_748_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_748_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_748_1:RecordName(arg_748_1.leftNameTxt_.text)
				SetActive(arg_748_1.iconTrs_.gameObject, false)
				arg_748_1.callingController_:SetSelectedState("normal")

				local var_751_4 = arg_748_1:GetWordFromCfg(1103404187)
				local var_751_5 = arg_748_1:FormatText(var_751_4.content)

				arg_748_1.text_.text = var_751_5

				LuaForUtil.ClearLinePrefixSymbol(arg_748_1.text_)

				local var_751_7 = 29 <= 0 and var_751_3 or var_751_3 * (utf8.len(var_751_5) / 29)

				if (29 <= 0 and var_751_3 or var_751_3 * (utf8.len(var_751_5) / 29)) > 0 and var_751_3 < var_751_7 then
					arg_748_1.talkMaxDuration = var_751_7

					if var_751_7 + var_751_2 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_7 + var_751_2
					end
				end

				arg_748_1.text_.text = var_751_5
				arg_748_1.typewritter.percent = 0

				arg_748_1.typewritter:SetDirty()
				arg_748_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb") ~= 0 then
					local var_751_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb") / 1000

					if var_751_8 + var_751_2 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_8 + var_751_2
					end

					if var_751_4.prefab_name ~= "" and arg_748_1.actors_[var_751_4.prefab_name] ~= nil then
						local var_751_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_748_1.actors_[var_751_4.prefab_name].transform, "story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")

						arg_748_1:RecordAudio("1103404187", var_751_9)
						arg_748_1:RecordAudio("1103404187", var_751_9)
					else
						arg_748_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")
					end

					arg_748_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")
				end

				arg_748_1:RecordContent(arg_748_1.text_.text)
			end

			local var_751_10 = math.max(var_751_3, arg_748_1.talkMaxDuration)

			if var_751_2 <= arg_748_1.time_ and arg_748_1.time_ < var_751_2 + var_751_10 then
				arg_748_1.typewritter.percent = (arg_748_1.time_ - var_751_2) / var_751_10

				arg_748_1.typewritter:SetDirty()
			end

			if arg_748_1.time_ >= var_751_2 + var_751_10 and arg_748_1.time_ < var_751_2 + var_751_10 + arg_751_0 then
				arg_748_1.typewritter.percent = 1

				arg_748_1.typewritter:SetDirty()
				arg_748_1:ShowNextGo(true)
			end
		end

		arg_748_1.nodeConfigList_ = {}

		arg_748_1:InitPlayNodeList()
	end,
	Play1103404188 = function(arg_752_0, arg_752_1)
		arg_752_1.time_ = 0
		arg_752_1.frameCnt_ = 0
		arg_752_1.state_ = "playing"
		arg_752_1.curTalkId_ = 1103404188
		arg_752_1.duration_ = 4.2

		SetActive(arg_752_1.tipsGo_, false)

		function arg_752_1.onSingleLineFinish_()
			arg_752_1.onSingleLineUpdate_ = nil
			arg_752_1.onSingleLineFinish_ = nil
			arg_752_1.state_ = "waiting"
		end

		function arg_752_1.playNext_(arg_754_0)
			if arg_754_0 == 1 then
				arg_752_0:Play1103404189(arg_752_1)
			end
		end

		function arg_752_1.onSingleLineUpdate_(arg_755_0)
			local var_755_0 = 0.35

			if 0 < arg_752_1.time_ and arg_752_1.time_ <= 0 + arg_755_0 then
				arg_752_1.talkMaxDuration = 0
				arg_752_1.dialogCg_.alpha = 1

				arg_752_1.dialog_:SetActive(true)
				SetActive(arg_752_1.leftNameGo_, true)

				arg_752_1.leftNameTxt_.text = arg_752_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_752_1.leftNameTxt_.transform)

				arg_752_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_752_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_752_1:RecordName(arg_752_1.leftNameTxt_.text)
				SetActive(arg_752_1.iconTrs_.gameObject, false)
				arg_752_1.callingController_:SetSelectedState("normal")

				local var_755_1 = arg_752_1:GetWordFromCfg(1103404188)
				local var_755_2 = arg_752_1:FormatText(var_755_1.content)

				arg_752_1.text_.text = var_755_2

				LuaForUtil.ClearLinePrefixSymbol(arg_752_1.text_)

				local var_755_4 = 14 <= 0 and var_755_0 or var_755_0 * (utf8.len(var_755_2) / 14)

				if (14 <= 0 and var_755_0 or var_755_0 * (utf8.len(var_755_2) / 14)) > 0 and var_755_0 < var_755_4 then
					arg_752_1.talkMaxDuration = var_755_4

					if var_755_4 + 0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_4 + 0
					end
				end

				arg_752_1.text_.text = var_755_2
				arg_752_1.typewritter.percent = 0

				arg_752_1.typewritter:SetDirty()
				arg_752_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb") ~= 0 then
					local var_755_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb") / 1000

					if var_755_5 + 0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_5 + 0
					end

					if var_755_1.prefab_name ~= "" and arg_752_1.actors_[var_755_1.prefab_name] ~= nil then
						local var_755_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_752_1.actors_[var_755_1.prefab_name].transform, "story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")

						arg_752_1:RecordAudio("1103404188", var_755_6)
						arg_752_1:RecordAudio("1103404188", var_755_6)
					else
						arg_752_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")
					end

					arg_752_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")
				end

				arg_752_1:RecordContent(arg_752_1.text_.text)
			end

			local var_755_7 = math.max(var_755_0, arg_752_1.talkMaxDuration)

			if 0 <= arg_752_1.time_ and arg_752_1.time_ < 0 + var_755_7 then
				arg_752_1.typewritter.percent = (arg_752_1.time_ - 0) / var_755_7

				arg_752_1.typewritter:SetDirty()
			end

			if arg_752_1.time_ >= 0 + var_755_7 and arg_752_1.time_ < 0 + var_755_7 + arg_755_0 then
				arg_752_1.typewritter.percent = 1

				arg_752_1.typewritter:SetDirty()
				arg_752_1:ShowNextGo(true)
			end
		end

		arg_752_1.nodeConfigList_ = {}

		arg_752_1:InitPlayNodeList()
	end,
	Play1103404189 = function(arg_756_0, arg_756_1)
		arg_756_1.time_ = 0
		arg_756_1.frameCnt_ = 0
		arg_756_1.state_ = "playing"
		arg_756_1.curTalkId_ = 1103404189
		arg_756_1.duration_ = 5

		SetActive(arg_756_1.tipsGo_, false)

		function arg_756_1.onSingleLineFinish_()
			arg_756_1.onSingleLineUpdate_ = nil
			arg_756_1.onSingleLineFinish_ = nil
			arg_756_1.state_ = "waiting"
		end

		function arg_756_1.playNext_(arg_758_0)
			if arg_758_0 == 1 then
				arg_756_0:Play1103404190(arg_756_1)
			end
		end

		function arg_756_1.onSingleLineUpdate_(arg_759_0)
			if 0 < arg_756_1.time_ and arg_756_1.time_ <= 0 + arg_759_0 and not isNil(arg_756_1.actors_["1034ui_story"]) and arg_756_1.var_.characterEffect1034ui_story == nil then
				arg_756_1.var_.characterEffect1034ui_story = arg_756_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_759_0 = 0.200000002980232

			if 0 <= arg_756_1.time_ and arg_756_1.time_ < 0 + var_759_0 and not isNil(arg_756_1.actors_["1034ui_story"]) then
				if arg_756_1.var_.characterEffect1034ui_story and not isNil(arg_756_1.actors_["1034ui_story"]) then
					arg_756_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_756_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_756_1.time_ - 0) / var_759_0)
				end
			end

			if arg_756_1.time_ >= 0 + var_759_0 and arg_756_1.time_ < 0 + var_759_0 + arg_759_0 and not isNil(arg_756_1.actors_["1034ui_story"]) and arg_756_1.var_.characterEffect1034ui_story then
				arg_756_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_756_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_756_1.time_ and arg_756_1.time_ <= 0 + arg_759_0 then
				arg_756_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_759_1 = 0
			local var_759_2 = 1.45

			if 0 < arg_756_1.time_ and arg_756_1.time_ <= var_759_1 + arg_759_0 then
				arg_756_1.talkMaxDuration = 0
				arg_756_1.dialogCg_.alpha = 1

				arg_756_1.dialog_:SetActive(true)
				SetActive(arg_756_1.leftNameGo_, false)

				arg_756_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_756_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_756_1:RecordName(arg_756_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_756_1.iconTrs_.gameObject, false)
				arg_756_1.callingController_:SetSelectedState("normal")

				local var_759_3 = arg_756_1:FormatText(arg_756_1:GetWordFromCfg(1103404189).content)

				arg_756_1.text_.text = var_759_3

				LuaForUtil.ClearLinePrefixSymbol(arg_756_1.text_)

				local var_759_5 = 58 <= 0 and var_759_2 or var_759_2 * (utf8.len(var_759_3) / 58)

				if (58 <= 0 and var_759_2 or var_759_2 * (utf8.len(var_759_3) / 58)) > 0 and var_759_2 < var_759_5 then
					arg_756_1.talkMaxDuration = var_759_5

					if var_759_5 + var_759_1 > arg_756_1.duration_ then
						arg_756_1.duration_ = var_759_5 + var_759_1
					end
				end

				arg_756_1.text_.text = var_759_3
				arg_756_1.typewritter.percent = 0

				arg_756_1.typewritter:SetDirty()
				arg_756_1:ShowNextGo(false)
				arg_756_1:RecordContent(arg_756_1.text_.text)
			end

			local var_759_6 = math.max(var_759_2, arg_756_1.talkMaxDuration)

			if var_759_1 <= arg_756_1.time_ and arg_756_1.time_ < var_759_1 + var_759_6 then
				arg_756_1.typewritter.percent = (arg_756_1.time_ - var_759_1) / var_759_6

				arg_756_1.typewritter:SetDirty()
			end

			if arg_756_1.time_ >= var_759_1 + var_759_6 and arg_756_1.time_ < var_759_1 + var_759_6 + arg_759_0 then
				arg_756_1.typewritter.percent = 1

				arg_756_1.typewritter:SetDirty()
				arg_756_1:ShowNextGo(true)
			end
		end

		arg_756_1.nodeConfigList_ = {}

		arg_756_1:InitPlayNodeList()
	end,
	Play1103404190 = function(arg_760_0, arg_760_1)
		arg_760_1.time_ = 0
		arg_760_1.frameCnt_ = 0
		arg_760_1.state_ = "playing"
		arg_760_1.curTalkId_ = 1103404190
		arg_760_1.duration_ = 5.4

		SetActive(arg_760_1.tipsGo_, false)

		function arg_760_1.onSingleLineFinish_()
			arg_760_1.onSingleLineUpdate_ = nil
			arg_760_1.onSingleLineFinish_ = nil
			arg_760_1.state_ = "waiting"
			arg_760_1.auto_ = false
		end

		function arg_760_1.playNext_(arg_762_0)
			arg_760_1.onStoryFinished_()
		end

		function arg_760_1.onSingleLineUpdate_(arg_763_0)
			if 0 < arg_760_1.time_ and arg_760_1.time_ <= 0 + arg_763_0 and not isNil(arg_760_1.actors_["1034ui_story"]) and arg_760_1.var_.characterEffect1034ui_story == nil then
				arg_760_1.var_.characterEffect1034ui_story = arg_760_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_763_0 = 0.200000002980232

			if 0 <= arg_760_1.time_ and arg_760_1.time_ < 0 + var_763_0 and not isNil(arg_760_1.actors_["1034ui_story"]) then
				if arg_760_1.var_.characterEffect1034ui_story and not isNil(arg_760_1.actors_["1034ui_story"]) then
					arg_760_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_760_1.time_ >= 0 + var_763_0 and arg_760_1.time_ < 0 + var_763_0 + arg_763_0 and not isNil(arg_760_1.actors_["1034ui_story"]) and arg_760_1.var_.characterEffect1034ui_story then
				arg_760_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_763_2 = 0
			local var_763_3 = 0.775

			if 0 < arg_760_1.time_ and arg_760_1.time_ <= var_763_2 + arg_763_0 then
				arg_760_1.talkMaxDuration = 0
				arg_760_1.dialogCg_.alpha = 1

				arg_760_1.dialog_:SetActive(true)
				SetActive(arg_760_1.leftNameGo_, true)

				arg_760_1.leftNameTxt_.text = arg_760_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_760_1.leftNameTxt_.transform)

				arg_760_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_760_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_760_1:RecordName(arg_760_1.leftNameTxt_.text)
				SetActive(arg_760_1.iconTrs_.gameObject, false)
				arg_760_1.callingController_:SetSelectedState("normal")

				local var_763_4 = arg_760_1:GetWordFromCfg(1103404190)
				local var_763_5 = arg_760_1:FormatText(var_763_4.content)

				arg_760_1.text_.text = var_763_5

				LuaForUtil.ClearLinePrefixSymbol(arg_760_1.text_)

				local var_763_7 = 31 <= 0 and var_763_3 or var_763_3 * (utf8.len(var_763_5) / 31)

				if (31 <= 0 and var_763_3 or var_763_3 * (utf8.len(var_763_5) / 31)) > 0 and var_763_3 < var_763_7 then
					arg_760_1.talkMaxDuration = var_763_7

					if var_763_7 + var_763_2 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_7 + var_763_2
					end
				end

				arg_760_1.text_.text = var_763_5
				arg_760_1.typewritter.percent = 0

				arg_760_1.typewritter:SetDirty()
				arg_760_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb") ~= 0 then
					local var_763_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb") / 1000

					if var_763_8 + var_763_2 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_8 + var_763_2
					end

					if var_763_4.prefab_name ~= "" and arg_760_1.actors_[var_763_4.prefab_name] ~= nil then
						local var_763_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_760_1.actors_[var_763_4.prefab_name].transform, "story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")

						arg_760_1:RecordAudio("1103404190", var_763_9)
						arg_760_1:RecordAudio("1103404190", var_763_9)
					else
						arg_760_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")
					end

					arg_760_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")
				end

				arg_760_1:RecordContent(arg_760_1.text_.text)
			end

			local var_763_10 = math.max(var_763_3, arg_760_1.talkMaxDuration)

			if var_763_2 <= arg_760_1.time_ and arg_760_1.time_ < var_763_2 + var_763_10 then
				arg_760_1.typewritter.percent = (arg_760_1.time_ - var_763_2) / var_763_10

				arg_760_1.typewritter:SetDirty()
			end

			if arg_760_1.time_ >= var_763_2 + var_763_10 and arg_760_1.time_ < var_763_2 + var_763_10 + arg_763_0 then
				arg_760_1.typewritter.percent = 1

				arg_760_1.typewritter:SetDirty()
				arg_760_1:ShowNextGo(true)
			end
		end

		arg_760_1.nodeConfigList_ = {}

		arg_760_1:InitPlayNodeList()
	end,
	Play1103404170 = function(arg_764_0, arg_764_1)
		arg_764_1.time_ = 0
		arg_764_1.frameCnt_ = 0
		arg_764_1.state_ = "playing"
		arg_764_1.curTalkId_ = 1103404170
		arg_764_1.duration_ = 5

		SetActive(arg_764_1.tipsGo_, false)

		function arg_764_1.onSingleLineFinish_()
			arg_764_1.onSingleLineUpdate_ = nil
			arg_764_1.onSingleLineFinish_ = nil
			arg_764_1.state_ = "waiting"
		end

		function arg_764_1.playNext_(arg_766_0)
			if arg_766_0 == 1 then
				arg_764_0:Play1103404171(arg_764_1)
			end
		end

		function arg_764_1.onSingleLineUpdate_(arg_767_0)
			local var_767_0 = 0.55

			if 0 < arg_764_1.time_ and arg_764_1.time_ <= 0 + arg_767_0 then
				arg_764_1.talkMaxDuration = 0
				arg_764_1.dialogCg_.alpha = 1

				arg_764_1.dialog_:SetActive(true)
				SetActive(arg_764_1.leftNameGo_, true)

				arg_764_1.leftNameTxt_.text = arg_764_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_764_1.leftNameTxt_.transform)

				arg_764_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_764_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_764_1:RecordName(arg_764_1.leftNameTxt_.text)
				SetActive(arg_764_1.iconTrs_.gameObject, false)
				arg_764_1.callingController_:SetSelectedState("normal")

				local var_767_1 = arg_764_1:GetWordFromCfg(1103404170)
				local var_767_2 = arg_764_1:FormatText(var_767_1.content)

				arg_764_1.text_.text = var_767_2

				LuaForUtil.ClearLinePrefixSymbol(arg_764_1.text_)

				local var_767_4 = 22 <= 0 and var_767_0 or var_767_0 * (utf8.len(var_767_2) / 22)

				if (22 <= 0 and var_767_0 or var_767_0 * (utf8.len(var_767_2) / 22)) > 0 and var_767_0 < var_767_4 then
					arg_764_1.talkMaxDuration = var_767_4

					if var_767_4 + 0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_4 + 0
					end
				end

				arg_764_1.text_.text = var_767_2
				arg_764_1.typewritter.percent = 0

				arg_764_1.typewritter:SetDirty()
				arg_764_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb") ~= 0 then
					local var_767_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb") / 1000

					if var_767_5 + 0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_5 + 0
					end

					if var_767_1.prefab_name ~= "" and arg_764_1.actors_[var_767_1.prefab_name] ~= nil then
						local var_767_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_764_1.actors_[var_767_1.prefab_name].transform, "story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")

						arg_764_1:RecordAudio("1103404170", var_767_6)
						arg_764_1:RecordAudio("1103404170", var_767_6)
					else
						arg_764_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")
					end

					arg_764_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")
				end

				arg_764_1:RecordContent(arg_764_1.text_.text)
			end

			local var_767_7 = math.max(var_767_0, arg_764_1.talkMaxDuration)

			if 0 <= arg_764_1.time_ and arg_764_1.time_ < 0 + var_767_7 then
				arg_764_1.typewritter.percent = (arg_764_1.time_ - 0) / var_767_7

				arg_764_1.typewritter:SetDirty()
			end

			if arg_764_1.time_ >= 0 + var_767_7 and arg_764_1.time_ < 0 + var_767_7 + arg_767_0 then
				arg_764_1.typewritter.percent = 1

				arg_764_1.typewritter:SetDirty()
				arg_764_1:ShowNextGo(true)
			end
		end

		arg_764_1.nodeConfigList_ = {}

		arg_764_1:InitPlayNodeList()
	end,
	Play1103404171 = function(arg_768_0, arg_768_1)
		arg_768_1.time_ = 0
		arg_768_1.frameCnt_ = 0
		arg_768_1.state_ = "playing"
		arg_768_1.curTalkId_ = 1103404171
		arg_768_1.duration_ = 6.67

		SetActive(arg_768_1.tipsGo_, false)

		function arg_768_1.onSingleLineFinish_()
			arg_768_1.onSingleLineUpdate_ = nil
			arg_768_1.onSingleLineFinish_ = nil
			arg_768_1.state_ = "waiting"
		end

		function arg_768_1.playNext_(arg_770_0)
			if arg_770_0 == 1 then
				arg_768_0:Play1103404172(arg_768_1)
			end
		end

		function arg_768_1.onSingleLineUpdate_(arg_771_0)
			local var_771_0 = 0.7

			if 0 < arg_768_1.time_ and arg_768_1.time_ <= 0 + arg_771_0 then
				arg_768_1.talkMaxDuration = 0
				arg_768_1.dialogCg_.alpha = 1

				arg_768_1.dialog_:SetActive(true)
				SetActive(arg_768_1.leftNameGo_, true)

				arg_768_1.leftNameTxt_.text = arg_768_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_768_1.leftNameTxt_.transform)

				arg_768_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_768_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_768_1:RecordName(arg_768_1.leftNameTxt_.text)
				SetActive(arg_768_1.iconTrs_.gameObject, false)
				arg_768_1.callingController_:SetSelectedState("normal")

				local var_771_1 = arg_768_1:GetWordFromCfg(1103404171)
				local var_771_2 = arg_768_1:FormatText(var_771_1.content)

				arg_768_1.text_.text = var_771_2

				LuaForUtil.ClearLinePrefixSymbol(arg_768_1.text_)

				local var_771_4 = 28 <= 0 and var_771_0 or var_771_0 * (utf8.len(var_771_2) / 28)

				if (28 <= 0 and var_771_0 or var_771_0 * (utf8.len(var_771_2) / 28)) > 0 and var_771_0 < var_771_4 then
					arg_768_1.talkMaxDuration = var_771_4

					if var_771_4 + 0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_4 + 0
					end
				end

				arg_768_1.text_.text = var_771_2
				arg_768_1.typewritter.percent = 0

				arg_768_1.typewritter:SetDirty()
				arg_768_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb") ~= 0 then
					local var_771_5 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb") / 1000

					if var_771_5 + 0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_5 + 0
					end

					if var_771_1.prefab_name ~= "" and arg_768_1.actors_[var_771_1.prefab_name] ~= nil then
						local var_771_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_768_1.actors_[var_771_1.prefab_name].transform, "story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")

						arg_768_1:RecordAudio("1103404171", var_771_6)
						arg_768_1:RecordAudio("1103404171", var_771_6)
					else
						arg_768_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")
					end

					arg_768_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")
				end

				arg_768_1:RecordContent(arg_768_1.text_.text)
			end

			local var_771_7 = math.max(var_771_0, arg_768_1.talkMaxDuration)

			if 0 <= arg_768_1.time_ and arg_768_1.time_ < 0 + var_771_7 then
				arg_768_1.typewritter.percent = (arg_768_1.time_ - 0) / var_771_7

				arg_768_1.typewritter:SetDirty()
			end

			if arg_768_1.time_ >= 0 + var_771_7 and arg_768_1.time_ < 0 + var_771_7 + arg_771_0 then
				arg_768_1.typewritter.percent = 1

				arg_768_1.typewritter:SetDirty()
				arg_768_1:ShowNextGo(true)
			end
		end

		arg_768_1.nodeConfigList_ = {}

		arg_768_1:InitPlayNodeList()
	end,
	Play1103404058 = function(arg_772_0, arg_772_1)
		arg_772_1.time_ = 0
		arg_772_1.frameCnt_ = 0
		arg_772_1.state_ = "playing"
		arg_772_1.curTalkId_ = 1103404058
		arg_772_1.duration_ = 2.03

		SetActive(arg_772_1.tipsGo_, false)

		function arg_772_1.onSingleLineFinish_()
			arg_772_1.onSingleLineUpdate_ = nil
			arg_772_1.onSingleLineFinish_ = nil
			arg_772_1.state_ = "waiting"
		end

		function arg_772_1.playNext_(arg_774_0)
			if arg_774_0 == 1 then
				arg_772_0:Play1103404059(arg_772_1)
			end
		end

		function arg_772_1.onSingleLineUpdate_(arg_775_0)
			if arg_772_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_775_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_772_1.stage_.transform)

				var_775_0.name = "1034ui_story"
				var_775_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_772_1.actors_["1034ui_story"] = var_775_0

				local var_775_1 = var_775_0:GetComponentInChildren(typeof(CharacterEffect))

				var_775_1.enabled = true

				local var_775_2 = GameObjectTools.GetOrAddComponent(var_775_0, typeof(DynamicBoneHelper))

				if var_775_2 then
					var_775_2:EnableDynamicBone(false)
				end

				arg_772_1:ShowWeapon(var_775_1.transform, false)

				arg_772_1.var_["1034ui_story" .. "Animator"] = var_775_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_772_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_772_1.var_["1034ui_story" .. "LipSync"] = var_775_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_772_1.time_ and arg_772_1.time_ <= 0 + arg_775_0 then
				arg_772_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			local var_775_3 = "1034ui_story"

			if arg_772_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_775_4 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_772_1.stage_.transform)

				var_775_4.name = var_775_3
				var_775_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_772_1.actors_[var_775_3] = var_775_4

				local var_775_5 = var_775_4:GetComponentInChildren(typeof(CharacterEffect))

				var_775_5.enabled = true

				local var_775_6 = GameObjectTools.GetOrAddComponent(var_775_4, typeof(DynamicBoneHelper))

				if var_775_6 then
					var_775_6:EnableDynamicBone(false)
				end

				arg_772_1:ShowWeapon(var_775_5.transform, false)

				arg_772_1.var_[var_775_3 .. "Animator"] = var_775_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_772_1.var_[var_775_3 .. "Animator"].applyRootMotion = true
				arg_772_1.var_[var_775_3 .. "LipSync"] = var_775_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_772_1.time_ and arg_772_1.time_ <= 0 + arg_775_0 then
				arg_772_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_775_7 = arg_772_1.actors_["1034ui_story"]

			if 0 < arg_772_1.time_ and arg_772_1.time_ <= 0 + arg_775_0 and not isNil(var_775_7) and arg_772_1.var_.characterEffect1034ui_story == nil then
				arg_772_1.var_.characterEffect1034ui_story = var_775_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_775_8 = 0.200000002980232

			if 0 <= arg_772_1.time_ and arg_772_1.time_ < 0 + var_775_8 and not isNil(var_775_7) then
				if arg_772_1.var_.characterEffect1034ui_story and not isNil(var_775_7) then
					arg_772_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_772_1.time_ >= 0 + var_775_8 and arg_772_1.time_ < 0 + var_775_8 + arg_775_0 and not isNil(var_775_7) and arg_772_1.var_.characterEffect1034ui_story then
				arg_772_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_775_10 = 0
			local var_775_11 = 0.225

			if 0 < arg_772_1.time_ and arg_772_1.time_ <= var_775_10 + arg_775_0 then
				arg_772_1.talkMaxDuration = 0
				arg_772_1.dialogCg_.alpha = 1

				arg_772_1.dialog_:SetActive(true)
				SetActive(arg_772_1.leftNameGo_, true)

				arg_772_1.leftNameTxt_.text = arg_772_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_772_1.leftNameTxt_.transform)

				arg_772_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_772_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_772_1:RecordName(arg_772_1.leftNameTxt_.text)
				SetActive(arg_772_1.iconTrs_.gameObject, false)
				arg_772_1.callingController_:SetSelectedState("normal")

				local var_775_12 = arg_772_1:GetWordFromCfg(1103404058)
				local var_775_13 = arg_772_1:FormatText(var_775_12.content)

				arg_772_1.text_.text = var_775_13

				LuaForUtil.ClearLinePrefixSymbol(arg_772_1.text_)

				local var_775_15 = 9 <= 0 and var_775_11 or var_775_11 * (utf8.len(var_775_13) / 9)

				if (9 <= 0 and var_775_11 or var_775_11 * (utf8.len(var_775_13) / 9)) > 0 and var_775_11 < var_775_15 then
					arg_772_1.talkMaxDuration = var_775_15

					if var_775_15 + var_775_10 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_15 + var_775_10
					end
				end

				arg_772_1.text_.text = var_775_13
				arg_772_1.typewritter.percent = 0

				arg_772_1.typewritter:SetDirty()
				arg_772_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb") ~= 0 then
					local var_775_16 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb") / 1000

					if var_775_16 + var_775_10 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_16 + var_775_10
					end

					if var_775_12.prefab_name ~= "" and arg_772_1.actors_[var_775_12.prefab_name] ~= nil then
						local var_775_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_772_1.actors_[var_775_12.prefab_name].transform, "story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")

						arg_772_1:RecordAudio("1103404058", var_775_17)
						arg_772_1:RecordAudio("1103404058", var_775_17)
					else
						arg_772_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")
					end

					arg_772_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")
				end

				arg_772_1:RecordContent(arg_772_1.text_.text)
			end

			local var_775_18 = math.max(var_775_11, arg_772_1.talkMaxDuration)

			if var_775_10 <= arg_772_1.time_ and arg_772_1.time_ < var_775_10 + var_775_18 then
				arg_772_1.typewritter.percent = (arg_772_1.time_ - var_775_10) / var_775_18

				arg_772_1.typewritter:SetDirty()
			end

			if arg_772_1.time_ >= var_775_10 + var_775_18 and arg_772_1.time_ < var_775_10 + var_775_18 + arg_775_0 then
				arg_772_1.typewritter.percent = 1

				arg_772_1.typewritter:SetDirty()
				arg_772_1:ShowNextGo(true)
			end
		end

		arg_772_1.nodeConfigList_ = {}

		arg_772_1:InitPlayNodeList()
	end,
	Play1103404059 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1103404059
		arg_776_1.duration_ = 3.6

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1103404062(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			if 0 < arg_776_1.time_ and arg_776_1.time_ <= 0 + arg_779_0 then
				arg_776_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_779_0 = 0
			local var_779_1 = 0.45

			if 0 < arg_776_1.time_ and arg_776_1.time_ <= var_779_0 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0
				arg_776_1.dialogCg_.alpha = 1

				arg_776_1.dialog_:SetActive(true)
				SetActive(arg_776_1.leftNameGo_, true)

				arg_776_1.leftNameTxt_.text = arg_776_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_776_1.leftNameTxt_.transform)

				arg_776_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_776_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_776_1:RecordName(arg_776_1.leftNameTxt_.text)
				SetActive(arg_776_1.iconTrs_.gameObject, false)
				arg_776_1.callingController_:SetSelectedState("normal")

				local var_779_2 = arg_776_1:GetWordFromCfg(1103404059)
				local var_779_3 = arg_776_1:FormatText(var_779_2.content)

				arg_776_1.text_.text = var_779_3

				LuaForUtil.ClearLinePrefixSymbol(arg_776_1.text_)

				local var_779_5 = 18 <= 0 and var_779_1 or var_779_1 * (utf8.len(var_779_3) / 18)

				if (18 <= 0 and var_779_1 or var_779_1 * (utf8.len(var_779_3) / 18)) > 0 and var_779_1 < var_779_5 then
					arg_776_1.talkMaxDuration = var_779_5

					if var_779_5 + var_779_0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_5 + var_779_0
					end
				end

				arg_776_1.text_.text = var_779_3
				arg_776_1.typewritter.percent = 0

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb") ~= 0 then
					local var_779_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb") / 1000

					if var_779_6 + var_779_0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_6 + var_779_0
					end

					if var_779_2.prefab_name ~= "" and arg_776_1.actors_[var_779_2.prefab_name] ~= nil then
						local var_779_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_776_1.actors_[var_779_2.prefab_name].transform, "story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")

						arg_776_1:RecordAudio("1103404059", var_779_7)
						arg_776_1:RecordAudio("1103404059", var_779_7)
					else
						arg_776_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")
					end

					arg_776_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")
				end

				arg_776_1:RecordContent(arg_776_1.text_.text)
			end

			local var_779_8 = math.max(var_779_1, arg_776_1.talkMaxDuration)

			if var_779_0 <= arg_776_1.time_ and arg_776_1.time_ < var_779_0 + var_779_8 then
				arg_776_1.typewritter.percent = (arg_776_1.time_ - var_779_0) / var_779_8

				arg_776_1.typewritter:SetDirty()
			end

			if arg_776_1.time_ >= var_779_0 + var_779_8 and arg_776_1.time_ < var_779_0 + var_779_8 + arg_779_0 then
				arg_776_1.typewritter.percent = 1

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(true)
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1103404060 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1103404060
		arg_780_1.duration_ = 2.4

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1103404061(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			if arg_780_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_783_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_780_1.stage_.transform)

				var_783_0.name = "1034ui_story"
				var_783_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_780_1.actors_["1034ui_story"] = var_783_0

				local var_783_1 = var_783_0:GetComponentInChildren(typeof(CharacterEffect))

				var_783_1.enabled = true

				local var_783_2 = GameObjectTools.GetOrAddComponent(var_783_0, typeof(DynamicBoneHelper))

				if var_783_2 then
					var_783_2:EnableDynamicBone(false)
				end

				arg_780_1:ShowWeapon(var_783_1.transform, false)

				arg_780_1.var_["1034ui_story" .. "Animator"] = var_783_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_780_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_780_1.var_["1034ui_story" .. "LipSync"] = var_783_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			local var_783_3 = "1034ui_story"

			if arg_780_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_783_4 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_780_1.stage_.transform)

				var_783_4.name = var_783_3
				var_783_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_780_1.actors_[var_783_3] = var_783_4

				local var_783_5 = var_783_4:GetComponentInChildren(typeof(CharacterEffect))

				var_783_5.enabled = true

				local var_783_6 = GameObjectTools.GetOrAddComponent(var_783_4, typeof(DynamicBoneHelper))

				if var_783_6 then
					var_783_6:EnableDynamicBone(false)
				end

				arg_780_1:ShowWeapon(var_783_5.transform, false)

				arg_780_1.var_[var_783_3 .. "Animator"] = var_783_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_780_1.var_[var_783_3 .. "Animator"].applyRootMotion = true
				arg_780_1.var_[var_783_3 .. "LipSync"] = var_783_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_783_7 = arg_780_1.actors_["1034ui_story"]

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 and not isNil(var_783_7) and arg_780_1.var_.characterEffect1034ui_story == nil then
				arg_780_1.var_.characterEffect1034ui_story = var_783_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_783_8 = 0.2

			if 0 <= arg_780_1.time_ and arg_780_1.time_ < 0 + var_783_8 and not isNil(var_783_7) then
				if arg_780_1.var_.characterEffect1034ui_story and not isNil(var_783_7) then
					arg_780_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_780_1.time_ >= 0 + var_783_8 and arg_780_1.time_ < 0 + var_783_8 + arg_783_0 and not isNil(var_783_7) and arg_780_1.var_.characterEffect1034ui_story then
				arg_780_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_783_10 = 0
			local var_783_11 = 0.275

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_10 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0
				arg_780_1.dialogCg_.alpha = 1

				arg_780_1.dialog_:SetActive(true)
				SetActive(arg_780_1.leftNameGo_, true)

				arg_780_1.leftNameTxt_.text = arg_780_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_780_1.leftNameTxt_.transform)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1.leftNameTxt_.text)
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_12 = arg_780_1:GetWordFromCfg(1103404060)
				local var_783_13 = arg_780_1:FormatText(var_783_12.content)

				arg_780_1.text_.text = var_783_13

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_15 = 11 <= 0 and var_783_11 or var_783_11 * (utf8.len(var_783_13) / 11)

				if (11 <= 0 and var_783_11 or var_783_11 * (utf8.len(var_783_13) / 11)) > 0 and var_783_11 < var_783_15 then
					arg_780_1.talkMaxDuration = var_783_15

					if var_783_15 + var_783_10 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_15 + var_783_10
					end
				end

				arg_780_1.text_.text = var_783_13
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb") ~= 0 then
					local var_783_16 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb") / 1000

					if var_783_16 + var_783_10 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_16 + var_783_10
					end

					if var_783_12.prefab_name ~= "" and arg_780_1.actors_[var_783_12.prefab_name] ~= nil then
						local var_783_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_780_1.actors_[var_783_12.prefab_name].transform, "story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")

						arg_780_1:RecordAudio("1103404060", var_783_17)
						arg_780_1:RecordAudio("1103404060", var_783_17)
					else
						arg_780_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")
					end

					arg_780_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")
				end

				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_18 = math.max(var_783_11, arg_780_1.talkMaxDuration)

			if var_783_10 <= arg_780_1.time_ and arg_780_1.time_ < var_783_10 + var_783_18 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_10) / var_783_18

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_10 + var_783_18 and arg_780_1.time_ < var_783_10 + var_783_18 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1103404061 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1103404061
		arg_784_1.duration_ = 5.1

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1103404062(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			if 0 < arg_784_1.time_ and arg_784_1.time_ <= 0 + arg_787_0 then
				arg_784_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_787_0 = 0
			local var_787_1 = 0.65

			if 0 < arg_784_1.time_ and arg_784_1.time_ <= var_787_0 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0
				arg_784_1.dialogCg_.alpha = 1

				arg_784_1.dialog_:SetActive(true)
				SetActive(arg_784_1.leftNameGo_, true)

				arg_784_1.leftNameTxt_.text = arg_784_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_784_1.leftNameTxt_.transform)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1.leftNameTxt_.text)
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_2 = arg_784_1:GetWordFromCfg(1103404061)
				local var_787_3 = arg_784_1:FormatText(var_787_2.content)

				arg_784_1.text_.text = var_787_3

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_5 = 26 <= 0 and var_787_1 or var_787_1 * (utf8.len(var_787_3) / 26)

				if (26 <= 0 and var_787_1 or var_787_1 * (utf8.len(var_787_3) / 26)) > 0 and var_787_1 < var_787_5 then
					arg_784_1.talkMaxDuration = var_787_5

					if var_787_5 + var_787_0 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_5 + var_787_0
					end
				end

				arg_784_1.text_.text = var_787_3
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb") ~= 0 then
					local var_787_6 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb") / 1000

					if var_787_6 + var_787_0 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_6 + var_787_0
					end

					if var_787_2.prefab_name ~= "" and arg_784_1.actors_[var_787_2.prefab_name] ~= nil then
						local var_787_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_784_1.actors_[var_787_2.prefab_name].transform, "story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")

						arg_784_1:RecordAudio("1103404061", var_787_7)
						arg_784_1:RecordAudio("1103404061", var_787_7)
					else
						arg_784_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")
					end

					arg_784_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")
				end

				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_8 = math.max(var_787_1, arg_784_1.talkMaxDuration)

			if var_787_0 <= arg_784_1.time_ and arg_784_1.time_ < var_787_0 + var_787_8 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_0) / var_787_8

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_0 + var_787_8 and arg_784_1.time_ < var_787_0 + var_787_8 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11p",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/R3401",
		"TextureConfig/Background/R3401a$naive"
	},
	voices = {
		"story_v_side_new_1103404.awb"
	}
}
