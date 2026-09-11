return {
	Play412022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412022001
		arg_1_1.duration_ = 9.23

		local var_1_0 = {
			zh = 5.366,
			ja = 9.233
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
				arg_1_0:Play412022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST86a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST86a")
				var_4_0.name = "ST86a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST86a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST86a

				arg_1_1.bgs_.ST86a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST86a" then
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

			local var_4_9 = "10083ui_story"

			if arg_1_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10083ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10083ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_1_1.time_ - 2) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -2.6, -2.8)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			local var_4_15 = arg_1_1.actors_["10083ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10083ui_story == nil then
				arg_1_1.var_.characterEffect10083ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10083ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10083ui_story then
				arg_1_1.var_.characterEffect10083ui_story.fillFlat = false
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

			local var_4_24 = 2
			local var_4_25 = 0.35

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(412022001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 14 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 14)

				if (14 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 14)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022001", "story_v_out_412022.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_412022", "412022001", "story_v_out_412022.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_412022", "412022001", "story_v_out_412022.awb")

						arg_1_1:RecordAudio("412022001", var_4_32)
						arg_1_1:RecordAudio("412022001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412022", "412022001", "story_v_out_412022.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412022", "412022001", "story_v_out_412022.awb")
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
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play412022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412022002
		arg_9_1.duration_ = 6.13

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10083ui_story = arg_9_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).z)
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles = arg_9_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["10083ui_story"].transform.position).z)
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["10083ui_story"].transform.localEulerAngles = arg_9_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_12_1 = manager.ui.mainCamera.transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_1.localPosition
			end

			local var_12_2 = 0.6

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 then
				local var_12_3, var_12_4 = math.modf((arg_9_1.time_ - 0) / 0.066)

				var_12_1.localPosition = Vector3.New(var_12_4 * 0.13, var_12_4 * 0.13, var_12_4 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 then
				var_12_1.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_5 = manager.ui.mainCamera.transform

			if 0.833333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.833333333333333 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_5.localPosition
			end

			local var_12_6 = 0.6

			if 0.833333333333333 <= arg_9_1.time_ and arg_9_1.time_ < 0.833333333333333 + var_12_6 then
				local var_12_7, var_12_8 = math.modf((arg_9_1.time_ - 0.833333333333333) / 0.066)

				var_12_5.localPosition = Vector3.New(var_12_8 * 0.13, var_12_8 * 0.13, var_12_8 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0.833333333333333 + var_12_6 and arg_9_1.time_ < 0.833333333333333 + var_12_6 + arg_12_0 then
				var_12_5.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_9 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_9 + 1.43333333333333 and arg_9_1.time_ < var_12_9 + 1.43333333333333 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_10 = 1.13333333333333
			local var_12_11 = 1.25

			if 1.13333333333333 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_12 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_12:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(412022002).content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 50 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 50)

				if (50 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 50)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15
					var_12_10 = var_12_10 + 0.3

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = var_12_10 + 0.3
			local var_12_17 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_17

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play412022003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 412022003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play412022004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:AudioAction("play", "effect", "se_story_132", "se_story_132_Weihua", "")
			end

			local var_18_1 = 0
			local var_18_2 = 0.5

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(412022003).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 20 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 20)

				if (20 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 20)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play412022004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 412022004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play412022005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 1.5

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(412022004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 60 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 60)

				if (60 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 60)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play412022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 412022005
		arg_23_1.duration_ = 5.5

		local var_23_0 = {
			zh = 4.966,
			ja = 5.5
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play412022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1097ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1097ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1097ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1097ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1097ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1097ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1097ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1097ui_story == nil then
				arg_23_1.var_.characterEffect1097ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1097ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1097ui_story then
				arg_23_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_26_8 = 0
			local var_26_9 = 0.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(412022005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 18 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 18)

				if (18 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 18)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022005", "story_v_out_412022.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022005", "story_v_out_412022.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_412022", "412022005", "story_v_out_412022.awb")

						arg_23_1:RecordAudio("412022005", var_26_15)
						arg_23_1:RecordAudio("412022005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_412022", "412022005", "story_v_out_412022.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_412022", "412022005", "story_v_out_412022.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play412022006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 412022006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play412022007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1097ui_story = arg_27_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).z)
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles = arg_27_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1097ui_story"].transform.position).z)
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1097ui_story"].transform.localEulerAngles = arg_27_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1097ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1097ui_story == nil then
				arg_27_1.var_.characterEffect1097ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1097ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_2)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1097ui_story then
				arg_27_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_30_3 = 0
			local var_30_4 = 0.575

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_5 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(412022006).content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 23 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 23)

				if (23 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 23)) > 0 and var_30_4 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_8 and arg_27_1.time_ < var_30_3 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play412022007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 412022007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play412022008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0.5 < arg_31_1.time_ and arg_31_1.time_ <= 0.5 + arg_34_0 then
				arg_31_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_34_0 = 0.6

			if 0.5 <= arg_31_1.time_ and arg_31_1.time_ < 0.5 + var_34_0 then
				local var_34_1, var_34_2 = math.modf((arg_31_1.time_ - 0.5) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_34_2 * 0.13, var_34_2 * 0.13, var_34_2 * 0.13) + arg_31_1.var_.shakeOldPos
			end

			if arg_31_1.time_ >= 0.5 + var_34_0 and arg_31_1.time_ < 0.5 + var_34_0 + arg_34_0 then
				manager.ui.mainCamera.transform.localPosition = arg_31_1.var_.shakeOldPos
			end

			local var_34_3 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_3 + 1.1 and arg_31_1.time_ < var_34_3 + 1.1 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_4 = 0
			local var_34_5 = 1.375

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(412022007).content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 55 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 55)

				if (55 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 55)) > 0 and var_34_5 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_9 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_9 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_9

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_9 and arg_31_1.time_ < var_34_4 + var_34_9 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play412022008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412022008
		arg_35_1.duration_ = 12.7

		local var_35_0 = {
			zh = 12.7,
			ja = 7.7
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
				arg_35_0:Play412022009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10083ui_story = arg_35_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).z)
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles = arg_35_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_35_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10083ui_story"].transform.position).z)
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10083ui_story"].transform.localEulerAngles = arg_35_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["10083ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10083ui_story == nil then
				arg_35_1.var_.characterEffect10083ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect10083ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10083ui_story then
				arg_35_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = 0
			local var_38_5 = 1.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(412022008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 56 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 56)

				if (56 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 56)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022008", "story_v_out_412022.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_412022", "412022008", "story_v_out_412022.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_412022", "412022008", "story_v_out_412022.awb")

						arg_35_1:RecordAudio("412022008", var_38_11)
						arg_35_1:RecordAudio("412022008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_412022", "412022008", "story_v_out_412022.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_412022", "412022008", "story_v_out_412022.awb")
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
				actorName = "10083ui_story",
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
	Play412022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412022009
		arg_39_1.duration_ = 14

		local var_39_0 = {
			zh = 10.2,
			ja = 14
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
				arg_39_0:Play412022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1097ui_story = arg_39_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).z)
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles = arg_39_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_39_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1097ui_story"].transform.position).z)
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1097ui_story"].transform.localEulerAngles = arg_39_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1097ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1097ui_story == nil then
				arg_39_1.var_.characterEffect1097ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1097ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1097ui_story then
				arg_39_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_42_4 = arg_39_1.actors_["10083ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10083ui_story = var_42_4.localPosition
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_5)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(0, 100, 0)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			local var_42_6 = arg_39_1.actors_["10083ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect10083ui_story == nil then
				arg_39_1.var_.characterEffect10083ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 and not isNil(var_42_6) then
				if arg_39_1.var_.characterEffect10083ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_7)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect10083ui_story then
				arg_39_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_42_8 = 0
			local var_42_9 = 0.775

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(412022009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 31 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 31)

				if (31 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 31)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022009", "story_v_out_412022.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022009", "story_v_out_412022.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_412022", "412022009", "story_v_out_412022.awb")

						arg_39_1:RecordAudio("412022009", var_42_15)
						arg_39_1:RecordAudio("412022009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_412022", "412022009", "story_v_out_412022.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_412022", "412022009", "story_v_out_412022.awb")
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

		arg_39_1:InitPlayNodeList()
	end,
	Play412022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412022010
		arg_43_1.duration_ = 5.6

		local var_43_0 = {
			zh = 3.533,
			ja = 5.6
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
				arg_43_0:Play412022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "10078ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["10078ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["10078ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["10078ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["10078ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10078ui_story = var_46_3.localPosition
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10078ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_43_1.time_ - 0) / var_46_4)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			local var_46_5 = arg_43_1.actors_["10078ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect10078ui_story == nil then
				arg_43_1.var_.characterEffect10078ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.characterEffect10078ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect10078ui_story then
				arg_43_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_8 = arg_43_1.actors_["1097ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1097ui_story = var_46_8.localPosition
			end

			local var_46_9 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_9 then
				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_9)
				var_46_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_8.position).x, (manager.ui.mainCamera.transform.position - var_46_8.position).y, (manager.ui.mainCamera.transform.position - var_46_8.position).z)
				var_46_8.localEulerAngles.z = 0
				var_46_8.localEulerAngles.x = 0
				var_46_8.localEulerAngles = var_46_8.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_9 and arg_43_1.time_ < 0 + var_46_9 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(0, 100, 0)
				var_46_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_8.position).x, (manager.ui.mainCamera.transform.position - var_46_8.position).y, (manager.ui.mainCamera.transform.position - var_46_8.position).z)
				var_46_8.localEulerAngles.z = 0
				var_46_8.localEulerAngles.x = 0
				var_46_8.localEulerAngles = var_46_8.localEulerAngles
			end

			local var_46_10 = arg_43_1.actors_["1097ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1097ui_story == nil then
				arg_43_1.var_.characterEffect1097ui_story = var_46_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_11 and not isNil(var_46_10) then
				if arg_43_1.var_.characterEffect1097ui_story and not isNil(var_46_10) then
					arg_43_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_11)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_11 and arg_43_1.time_ < 0 + var_46_11 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1097ui_story then
				arg_43_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_46_12 = 0
			local var_46_13 = 0.25

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(412022010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 10 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 10)

				if (10 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 10)) > 0 and var_46_13 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022010", "story_v_out_412022.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_412022", "412022010", "story_v_out_412022.awb") / 1000

					if var_46_18 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_12
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_412022", "412022010", "story_v_out_412022.awb")

						arg_43_1:RecordAudio("412022010", var_46_19)
						arg_43_1:RecordAudio("412022010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412022", "412022010", "story_v_out_412022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412022", "412022010", "story_v_out_412022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_20 and arg_43_1.time_ < var_46_12 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play412022011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 412022011
		arg_47_1.duration_ = 10.6

		local var_47_0 = {
			zh = 10.6,
			ja = 6.7
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
				arg_47_0:Play412022012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10083ui_story = arg_47_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10083ui_story, Vector3.New(1, -2.6, -2.8), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).z)
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles = arg_47_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(1, -2.6, -2.8)
				arg_47_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10083ui_story"].transform.position).z)
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10083ui_story"].transform.localEulerAngles = arg_47_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10083ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10083ui_story == nil then
				arg_47_1.var_.characterEffect10083ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10083ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10083ui_story then
				arg_47_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = arg_47_1.actors_["10078ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10078ui_story == nil then
				arg_47_1.var_.characterEffect10078ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect10078ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10078ui_story then
				arg_47_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_50_6 = 0
			local var_50_7 = 1.175

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(412022011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 47 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 47)

				if (47 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 47)) > 0 and var_50_7 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022011", "story_v_out_412022.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_412022", "412022011", "story_v_out_412022.awb") / 1000

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_412022", "412022011", "story_v_out_412022.awb")

						arg_47_1:RecordAudio("412022011", var_50_13)
						arg_47_1:RecordAudio("412022011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_412022", "412022011", "story_v_out_412022.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_412022", "412022011", "story_v_out_412022.awb")
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
				actorName = "10083ui_story",
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
	Play412022012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 412022012
		arg_51_1.duration_ = 5.9

		local var_51_0 = {
			zh = 1.999999999999,
			ja = 5.9
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
				arg_51_0:Play412022013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10078ui_story"]) and arg_51_1.var_.characterEffect10078ui_story == nil then
				arg_51_1.var_.characterEffect10078ui_story = arg_51_1.actors_["10078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10078ui_story"]) then
				if arg_51_1.var_.characterEffect10078ui_story and not isNil(arg_51_1.actors_["10078ui_story"]) then
					arg_51_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10078ui_story"]) and arg_51_1.var_.characterEffect10078ui_story then
				arg_51_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_2 = arg_51_1.actors_["10083ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect10083ui_story == nil then
				arg_51_1.var_.characterEffect10083ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect10083ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect10083ui_story then
				arg_51_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_54_4 = 0
			local var_54_5 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(412022012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 6 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 6)

				if (6 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 6)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022012", "story_v_out_412022.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_412022", "412022012", "story_v_out_412022.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_412022", "412022012", "story_v_out_412022.awb")

						arg_51_1:RecordAudio("412022012", var_54_11)
						arg_51_1:RecordAudio("412022012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_412022", "412022012", "story_v_out_412022.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_412022", "412022012", "story_v_out_412022.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play412022013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 412022013
		arg_55_1.duration_ = 6.3

		local var_55_0 = {
			zh = 4.9,
			ja = 6.3
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
				arg_55_0:Play412022014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_58_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_55_1.stage_.transform)

				var_58_0.name = "10076ui_story"
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["10076ui_story"] = var_58_0

				local var_58_1 = var_58_0:GetComponentInChildren(typeof(CharacterEffect))

				var_58_1.enabled = true

				local var_58_2 = GameObjectTools.GetOrAddComponent(var_58_0, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_1.transform, false)

				arg_55_1.var_["10076ui_story" .. "Animator"] = var_58_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_55_1.var_["10076ui_story" .. "LipSync"] = var_58_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_58_3 = arg_55_1.actors_["10076ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10076ui_story = var_58_3.localPosition
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_3.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_55_1.time_ - 0) / var_58_4)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_3.localPosition = Vector3.New(0, -0.35, -4)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			local var_58_5 = arg_55_1.actors_["10076ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect10076ui_story == nil then
				arg_55_1.var_.characterEffect10076ui_story = var_58_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.characterEffect10076ui_story and not isNil(var_58_5) then
					arg_55_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect10076ui_story then
				arg_55_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action6_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_8 = arg_55_1.actors_["10083ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10083ui_story = var_58_8.localPosition
			end

			local var_58_9 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_9 then
				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_9)
				var_58_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_8.position).x, (manager.ui.mainCamera.transform.position - var_58_8.position).y, (manager.ui.mainCamera.transform.position - var_58_8.position).z)
				var_58_8.localEulerAngles.z = 0
				var_58_8.localEulerAngles.x = 0
				var_58_8.localEulerAngles = var_58_8.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_9 and arg_55_1.time_ < 0 + var_58_9 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(0, 100, 0)
				var_58_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_8.position).x, (manager.ui.mainCamera.transform.position - var_58_8.position).y, (manager.ui.mainCamera.transform.position - var_58_8.position).z)
				var_58_8.localEulerAngles.z = 0
				var_58_8.localEulerAngles.x = 0
				var_58_8.localEulerAngles = var_58_8.localEulerAngles
			end

			local var_58_10 = arg_55_1.actors_["10083ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_10) and arg_55_1.var_.characterEffect10083ui_story == nil then
				arg_55_1.var_.characterEffect10083ui_story = var_58_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_11 and not isNil(var_58_10) then
				if arg_55_1.var_.characterEffect10083ui_story and not isNil(var_58_10) then
					arg_55_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_11)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_11 and arg_55_1.time_ < 0 + var_58_11 + arg_58_0 and not isNil(var_58_10) and arg_55_1.var_.characterEffect10083ui_story then
				arg_55_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_58_12 = arg_55_1.actors_["10078ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10078ui_story = var_58_12.localPosition
			end

			local var_58_13 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_13 then
				var_58_12.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_13)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_13 and arg_55_1.time_ < 0 + var_58_13 + arg_58_0 then
				var_58_12.localPosition = Vector3.New(0, 100, 0)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			local var_58_14 = arg_55_1.actors_["10078ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect10078ui_story == nil then
				arg_55_1.var_.characterEffect10078ui_story = var_58_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_15 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_15 and not isNil(var_58_14) then
				if arg_55_1.var_.characterEffect10078ui_story and not isNil(var_58_14) then
					arg_55_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_15)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_15 and arg_55_1.time_ < 0 + var_58_15 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect10078ui_story then
				arg_55_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_58_16 = 0
			local var_58_17 = 0.625

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(412022013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 25 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 25)

				if (25 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 25)) > 0 and var_58_17 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21

					if var_58_21 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022013", "story_v_out_412022.awb") ~= 0 then
					local var_58_22 = manager.audio:GetVoiceLength("story_v_out_412022", "412022013", "story_v_out_412022.awb") / 1000

					if var_58_22 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_16
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_412022", "412022013", "story_v_out_412022.awb")

						arg_55_1:RecordAudio("412022013", var_58_23)
						arg_55_1:RecordAudio("412022013", var_58_23)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_412022", "412022013", "story_v_out_412022.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_412022", "412022013", "story_v_out_412022.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_16) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_24 and arg_55_1.time_ < var_58_16 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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

		arg_55_1:InitPlayNodeList()
	end,
	Play412022014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 412022014
		arg_59_1.duration_ = 3.63

		local var_59_0 = {
			zh = 3.366,
			ja = 3.633
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
				arg_59_0:Play412022015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1097ui_story = arg_59_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).z)
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles = arg_59_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_59_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1097ui_story"].transform.position).z)
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1097ui_story"].transform.localEulerAngles = arg_59_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1097ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1097ui_story == nil then
				arg_59_1.var_.characterEffect1097ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1097ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1097ui_story then
				arg_59_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = arg_59_1.actors_["10076ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10076ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0, 100, 0)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["10076ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10076ui_story == nil then
				arg_59_1.var_.characterEffect10076ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect10076ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10076ui_story then
				arg_59_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_62_8 = 0
			local var_62_9 = 0.25

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(412022014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 10 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 10)

				if (10 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 10)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022014", "story_v_out_412022.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022014", "story_v_out_412022.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_412022", "412022014", "story_v_out_412022.awb")

						arg_59_1:RecordAudio("412022014", var_62_15)
						arg_59_1:RecordAudio("412022014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_412022", "412022014", "story_v_out_412022.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_412022", "412022014", "story_v_out_412022.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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
				actorName = "10076ui_story",
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
	Play412022015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 412022015
		arg_63_1.duration_ = 10.3

		local var_63_0 = {
			zh = 10.3,
			ja = 8.633
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
				arg_63_0:Play412022016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.975

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(412022015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 39 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 39)

				if (39 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 39)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022015", "story_v_out_412022.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_412022", "412022015", "story_v_out_412022.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_412022", "412022015", "story_v_out_412022.awb")

						arg_63_1:RecordAudio("412022015", var_66_6)
						arg_63_1:RecordAudio("412022015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_412022", "412022015", "story_v_out_412022.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_412022", "412022015", "story_v_out_412022.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play412022016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 412022016
		arg_67_1.duration_ = 3.87

		local var_67_0 = {
			zh = 1.999999999999,
			ja = 3.866
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
				arg_67_0:Play412022017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10083ui_story = arg_67_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).z)
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles = arg_67_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_67_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10083ui_story"].transform.position).z)
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10083ui_story"].transform.localEulerAngles = arg_67_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["10083ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect10083ui_story == nil then
				arg_67_1.var_.characterEffect10083ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect10083ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect10083ui_story then
				arg_67_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_4 = arg_67_1.actors_["1097ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1097ui_story = var_70_4.localPosition
			end

			local var_70_5 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 then
				var_70_4.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_5)
				var_70_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_4.position).x, (manager.ui.mainCamera.transform.position - var_70_4.position).y, (manager.ui.mainCamera.transform.position - var_70_4.position).z)
				var_70_4.localEulerAngles.z = 0
				var_70_4.localEulerAngles.x = 0
				var_70_4.localEulerAngles = var_70_4.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 then
				var_70_4.localPosition = Vector3.New(0, 100, 0)
				var_70_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_4.position).x, (manager.ui.mainCamera.transform.position - var_70_4.position).y, (manager.ui.mainCamera.transform.position - var_70_4.position).z)
				var_70_4.localEulerAngles.z = 0
				var_70_4.localEulerAngles.x = 0
				var_70_4.localEulerAngles = var_70_4.localEulerAngles
			end

			local var_70_6 = arg_67_1.actors_["1097ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1097ui_story == nil then
				arg_67_1.var_.characterEffect1097ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_7 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 and not isNil(var_70_6) then
				if arg_67_1.var_.characterEffect1097ui_story and not isNil(var_70_6) then
					arg_67_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_7)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1097ui_story then
				arg_67_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_70_8 = 0
			local var_70_9 = 0.125

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(412022016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 5 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 5)

				if (5 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 5)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022016", "story_v_out_412022.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022016", "story_v_out_412022.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_412022", "412022016", "story_v_out_412022.awb")

						arg_67_1:RecordAudio("412022016", var_70_15)
						arg_67_1:RecordAudio("412022016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_412022", "412022016", "story_v_out_412022.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_412022", "412022016", "story_v_out_412022.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play412022017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 412022017
		arg_71_1.duration_ = 7

		local var_71_0 = {
			zh = 5.766,
			ja = 7
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
				arg_71_0:Play412022018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1097ui_story = arg_71_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).z)
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles = arg_71_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_71_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).z)
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles = arg_71_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1097ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1097ui_story == nil then
				arg_71_1.var_.characterEffect1097ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1097ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1097ui_story then
				arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_4 = arg_71_1.actors_["10083ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10083ui_story = var_74_4.localPosition
			end

			local var_74_5 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 then
				var_74_4.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_5)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 then
				var_74_4.localPosition = Vector3.New(0, 100, 0)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			local var_74_6 = arg_71_1.actors_["10083ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10083ui_story == nil then
				arg_71_1.var_.characterEffect10083ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_7 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 and not isNil(var_74_6) then
				if arg_71_1.var_.characterEffect10083ui_story and not isNil(var_74_6) then
					arg_71_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_7)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10083ui_story then
				arg_71_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_74_8 = 0
			local var_74_9 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(412022017)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 20 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 20)

				if (20 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 20)) > 0 and var_74_9 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022017", "story_v_out_412022.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022017", "story_v_out_412022.awb") / 1000

					if var_74_14 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_8
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_412022", "412022017", "story_v_out_412022.awb")

						arg_71_1:RecordAudio("412022017", var_74_15)
						arg_71_1:RecordAudio("412022017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_412022", "412022017", "story_v_out_412022.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_412022", "412022017", "story_v_out_412022.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play412022018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 412022018
		arg_75_1.duration_ = 4.17

		local var_75_0 = {
			zh = 2.766,
			ja = 4.166
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
				arg_75_0:Play412022019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10076ui_story = arg_75_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).z)
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles = arg_75_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_75_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10076ui_story"].transform.position).z)
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10076ui_story"].transform.localEulerAngles = arg_75_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["10076ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10076ui_story == nil then
				arg_75_1.var_.characterEffect10076ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect10076ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10076ui_story then
				arg_75_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_4 = arg_75_1.actors_["1097ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1097ui_story = var_78_4.localPosition
			end

			local var_78_5 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_5)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, 100, 0)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			local var_78_6 = arg_75_1.actors_["1097ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1097ui_story == nil then
				arg_75_1.var_.characterEffect1097ui_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_7 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 and not isNil(var_78_6) then
				if arg_75_1.var_.characterEffect1097ui_story and not isNil(var_78_6) then
					arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_7)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1097ui_story then
				arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_78_8 = 0
			local var_78_9 = 0.35

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(412022018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 14 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 14)

				if (14 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 14)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022018", "story_v_out_412022.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022018", "story_v_out_412022.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_412022", "412022018", "story_v_out_412022.awb")

						arg_75_1:RecordAudio("412022018", var_78_15)
						arg_75_1:RecordAudio("412022018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_412022", "412022018", "story_v_out_412022.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_412022", "412022018", "story_v_out_412022.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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

		arg_75_1:InitPlayNodeList()
	end,
	Play412022019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 412022019
		arg_79_1.duration_ = 8.13

		local var_79_0 = {
			zh = 6.133,
			ja = 8.133
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play412022020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10083ui_story = arg_79_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).z)
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles = arg_79_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_79_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10083ui_story"].transform.position).z)
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10083ui_story"].transform.localEulerAngles = arg_79_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10083ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10083ui_story == nil then
				arg_79_1.var_.characterEffect10083ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10083ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10083ui_story then
				arg_79_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_4 = arg_79_1.actors_["10076ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10076ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0, 100, 0)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			local var_82_6 = arg_79_1.actors_["10076ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10076ui_story == nil then
				arg_79_1.var_.characterEffect10076ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_7 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 and not isNil(var_82_6) then
				if arg_79_1.var_.characterEffect10076ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_7)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10076ui_story then
				arg_79_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_82_8 = 0
			local var_82_9 = 0.8

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(412022019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 32 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 32)

				if (32 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 32)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022019", "story_v_out_412022.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022019", "story_v_out_412022.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_412022", "412022019", "story_v_out_412022.awb")

						arg_79_1:RecordAudio("412022019", var_82_15)
						arg_79_1:RecordAudio("412022019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_412022", "412022019", "story_v_out_412022.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_412022", "412022019", "story_v_out_412022.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play412022020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 412022020
		arg_83_1.duration_ = 3.37

		local var_83_0 = {
			zh = 2.7,
			ja = 3.366
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play412022021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10078ui_story = arg_83_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).z)
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles = arg_83_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_83_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10078ui_story"].transform.position).z)
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10078ui_story"].transform.localEulerAngles = arg_83_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["10078ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10078ui_story == nil then
				arg_83_1.var_.characterEffect10078ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect10078ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10078ui_story then
				arg_83_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_4 = arg_83_1.actors_["10083ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10083ui_story = var_86_4.localPosition
			end

			local var_86_5 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_5 then
				var_86_4.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_5)
				var_86_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_4.position).x, (manager.ui.mainCamera.transform.position - var_86_4.position).y, (manager.ui.mainCamera.transform.position - var_86_4.position).z)
				var_86_4.localEulerAngles.z = 0
				var_86_4.localEulerAngles.x = 0
				var_86_4.localEulerAngles = var_86_4.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_5 and arg_83_1.time_ < 0 + var_86_5 + arg_86_0 then
				var_86_4.localPosition = Vector3.New(0, 100, 0)
				var_86_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_4.position).x, (manager.ui.mainCamera.transform.position - var_86_4.position).y, (manager.ui.mainCamera.transform.position - var_86_4.position).z)
				var_86_4.localEulerAngles.z = 0
				var_86_4.localEulerAngles.x = 0
				var_86_4.localEulerAngles = var_86_4.localEulerAngles
			end

			local var_86_6 = arg_83_1.actors_["10083ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_6) and arg_83_1.var_.characterEffect10083ui_story == nil then
				arg_83_1.var_.characterEffect10083ui_story = var_86_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_7 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 and not isNil(var_86_6) then
				if arg_83_1.var_.characterEffect10083ui_story and not isNil(var_86_6) then
					arg_83_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_7)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 and not isNil(var_86_6) and arg_83_1.var_.characterEffect10083ui_story then
				arg_83_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_86_8 = 0
			local var_86_9 = 0.175

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(412022020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 7 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 7)

				if (7 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 7)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022020", "story_v_out_412022.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022020", "story_v_out_412022.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_out_412022", "412022020", "story_v_out_412022.awb")

						arg_83_1:RecordAudio("412022020", var_86_15)
						arg_83_1:RecordAudio("412022020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_412022", "412022020", "story_v_out_412022.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_412022", "412022020", "story_v_out_412022.awb")
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

		arg_83_1:InitPlayNodeList()
	end,
	Play412022021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 412022021
		arg_87_1.duration_ = 4.83

		local var_87_0 = {
			zh = 2.7,
			ja = 4.833
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
			arg_87_1.auto_ = false
		end

		function arg_87_1.playNext_(arg_89_0)
			arg_87_1.onStoryFinished_()
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1097ui_story = arg_87_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).z)
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles = arg_87_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_87_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).z)
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles = arg_87_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1097ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1097ui_story == nil then
				arg_87_1.var_.characterEffect1097ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1097ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1097ui_story then
				arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_4 = arg_87_1.actors_["10078ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10078ui_story = var_90_4.localPosition
			end

			local var_90_5 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 then
				var_90_4.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_5)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 then
				var_90_4.localPosition = Vector3.New(0, 100, 0)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			local var_90_6 = arg_87_1.actors_["10078ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect10078ui_story == nil then
				arg_87_1.var_.characterEffect10078ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_7 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 and not isNil(var_90_6) then
				if arg_87_1.var_.characterEffect10078ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_7)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect10078ui_story then
				arg_87_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_90_8 = 0
			local var_90_9 = 0.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(412022021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 9 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 9)

				if (9 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 9)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412022", "412022021", "story_v_out_412022.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_412022", "412022021", "story_v_out_412022.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_412022", "412022021", "story_v_out_412022.awb")

						arg_87_1:RecordAudio("412022021", var_90_15)
						arg_87_1:RecordAudio("412022021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_412022", "412022021", "story_v_out_412022.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_412022", "412022021", "story_v_out_412022.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST86a"
	},
	voices = {
		"story_v_out_412022.awb"
	}
}
