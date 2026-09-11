return {
	Play321202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321202001
		arg_1_1.duration_ = 8.83

		local var_1_0 = {
			zh = 8.833,
			ja = 8.233
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
				arg_1_0:Play321202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L15f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_4_0.name = "L15f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L15f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L15f

				arg_1_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L15f" then
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

			local var_4_9 = "404001ui_story"

			if arg_1_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["404001ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos404001ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.55, -5.5)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["404001ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect404001ui_story == nil then
				arg_1_1.var_.characterEffect404001ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect404001ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect404001ui_story then
				arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
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
			local var_4_25 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321202001)
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

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202001", "story_v_out_321202.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321202", "321202001", "story_v_out_321202.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321202", "321202001", "story_v_out_321202.awb")

						arg_1_1:RecordAudio("321202001", var_4_32)
						arg_1_1:RecordAudio("321202001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321202", "321202001", "story_v_out_321202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321202", "321202001", "story_v_out_321202.awb")
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
				actorName = "404001ui_story",
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
	Play321202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321202002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = arg_9_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).z)
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles = arg_9_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["404001ui_story"].transform.position).z)
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["404001ui_story"].transform.localEulerAngles = arg_9_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["404001ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect404001ui_story == nil then
				arg_9_1.var_.characterEffect404001ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect404001ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_9_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect404001ui_story then
				arg_9_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_9_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_9_1.time_ and arg_9_1.time_ <= 0.034000001847744 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tentacle2", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.6

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

				local var_12_6 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321202002).content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 64 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 64)

				if (64 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 64)) > 0 and var_12_5 < var_12_8 then
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
				actorName = "404001ui_story",
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
	Play321202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321202003
		arg_13_1.duration_ = 3.1

		local var_13_0 = {
			zh = 1.2,
			ja = 3.1
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
				arg_13_0:Play321202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1185].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(321202003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)

				if (5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202003", "story_v_out_321202.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202003", "story_v_out_321202.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_321202", "321202003", "story_v_out_321202.awb")

						arg_13_1:RecordAudio("321202003", var_16_6)
						arg_13_1:RecordAudio("321202003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321202", "321202003", "story_v_out_321202.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321202", "321202003", "story_v_out_321202.awb")
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
	Play321202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321202004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = arg_17_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["404001ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(321202004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 2 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 2)

				if (2 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 2)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202004", "story_v_out_321202.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202004", "story_v_out_321202.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_321202", "321202004", "story_v_out_321202.awb")

						arg_17_1:RecordAudio("321202004", var_20_11)
						arg_17_1:RecordAudio("321202004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321202", "321202004", "story_v_out_321202.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321202", "321202004", "story_v_out_321202.awb")
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
				actorName = "404001ui_story",
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
	Play321202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321202005
		arg_21_1.duration_ = 3.03

		local var_21_0 = {
			zh = 2,
			ja = 3.033
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
				arg_21_0:Play321202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) and arg_21_1.var_.characterEffect404001ui_story == nil then
				arg_21_1.var_.characterEffect404001ui_story = arg_21_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) then
				if arg_21_1.var_.characterEffect404001ui_story and not isNil(arg_21_1.actors_["404001ui_story"]) then
					arg_21_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_21_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["404001ui_story"]) and arg_21_1.var_.characterEffect404001ui_story then
				arg_21_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_21_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1185].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(321202005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 8 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 8)

				if (8 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 8)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202005", "story_v_out_321202.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_321202", "321202005", "story_v_out_321202.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_321202", "321202005", "story_v_out_321202.awb")

						arg_21_1:RecordAudio("321202005", var_24_8)
						arg_21_1:RecordAudio("321202005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321202", "321202005", "story_v_out_321202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321202", "321202005", "story_v_out_321202.awb")
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
	Play321202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321202006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = arg_25_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).z)
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles = arg_25_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).z)
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles = arg_25_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 1.075

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

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(321202006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 43 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 43)

				if (43 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 43)) > 0 and var_28_2 < var_28_5 then
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

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play321202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321202007
		arg_29_1.duration_ = 2.83

		local var_29_0 = {
			zh = 2.8,
			ja = 2.833
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
				arg_29_0:Play321202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1185].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(321202007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)

				if (11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202007", "story_v_out_321202.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202007", "story_v_out_321202.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_321202", "321202007", "story_v_out_321202.awb")

						arg_29_1:RecordAudio("321202007", var_32_6)
						arg_29_1:RecordAudio("321202007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321202", "321202007", "story_v_out_321202.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321202", "321202007", "story_v_out_321202.awb")
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
	Play321202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321202008
		arg_33_1.duration_ = 5

		local var_33_0 = {
			zh = 3.733,
			ja = 5
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
				arg_33_0:Play321202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos404001ui_story = arg_33_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).z)
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles = arg_33_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_33_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).z)
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles = arg_33_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["404001ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_36_4 = 0
			local var_36_5 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(321202008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 20 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 20)

				if (20 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 20)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202008", "story_v_out_321202.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202008", "story_v_out_321202.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_321202", "321202008", "story_v_out_321202.awb")

						arg_33_1:RecordAudio("321202008", var_36_11)
						arg_33_1:RecordAudio("321202008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321202", "321202008", "story_v_out_321202.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321202", "321202008", "story_v_out_321202.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play321202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321202009
		arg_37_1.duration_ = 4.4

		local var_37_0 = {
			zh = 2.1,
			ja = 4.4
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
				arg_37_0:Play321202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.225

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(321202009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 9 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 9)

				if (9 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 9)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202009", "story_v_out_321202.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202009", "story_v_out_321202.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_321202", "321202009", "story_v_out_321202.awb")

						arg_37_1:RecordAudio("321202009", var_40_6)
						arg_37_1:RecordAudio("321202009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321202", "321202009", "story_v_out_321202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321202", "321202009", "story_v_out_321202.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321202010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos404001ui_story = arg_41_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).z)
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles = arg_41_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).z)
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles = arg_41_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["404001ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_41_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_41_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 1.16666666666667 < arg_41_1.time_ and arg_41_1.time_ <= 1.16666666666667 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_44_4 = 0
			local var_44_5 = 1.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(321202010).content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 57 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 57)

				if (57 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 57)) > 0 and var_44_5 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_9 and arg_41_1.time_ < var_44_4 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play321202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321202011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play321202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos404001ui_story = arg_45_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).z)
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles = arg_45_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_45_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["404001ui_story"].transform.position).z)
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["404001ui_story"].transform.localEulerAngles = arg_45_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["404001ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 0.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(321202011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 5 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 5)

				if (5 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 5)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202011", "story_v_out_321202.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202011", "story_v_out_321202.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_321202", "321202011", "story_v_out_321202.awb")

						arg_45_1:RecordAudio("321202011", var_48_11)
						arg_45_1:RecordAudio("321202011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321202", "321202011", "story_v_out_321202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321202", "321202011", "story_v_out_321202.awb")
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
				actorName = "404001ui_story",
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
	Play321202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321202012
		arg_49_1.duration_ = 11.37

		local var_49_0 = {
			zh = 4.4,
			ja = 11.366
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
				arg_49_0:Play321202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "1011ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1011ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["1011ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["1011ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["1011ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1011ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1011ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1011ui_story == nil then
				arg_49_1.var_.characterEffect1011ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1011ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1011ui_story then
				arg_49_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_52_8 = arg_49_1.actors_["404001ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = var_52_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_9 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_9 and not isNil(var_52_8) then
				if arg_49_1.var_.characterEffect404001ui_story and not isNil(var_52_8) then
					arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_49_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_9)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_9 and arg_49_1.time_ < 0 + var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.characterEffect404001ui_story then
				arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_49_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_52_10 = 0
			local var_52_11 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_12 = arg_49_1:GetWordFromCfg(321202012)
				local var_52_13 = arg_49_1:FormatText(var_52_12.content)

				arg_49_1.text_.text = var_52_13

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 20 <= 0 and var_52_11 or var_52_11 * (utf8.len(var_52_13) / 20)

				if (20 <= 0 and var_52_11 or var_52_11 * (utf8.len(var_52_13) / 20)) > 0 and var_52_11 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_13
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202012", "story_v_out_321202.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_321202", "321202012", "story_v_out_321202.awb") / 1000

					if var_52_16 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_10
					end

					if var_52_12.prefab_name ~= "" and arg_49_1.actors_[var_52_12.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_12.prefab_name].transform, "story_v_out_321202", "321202012", "story_v_out_321202.awb")

						arg_49_1:RecordAudio("321202012", var_52_17)
						arg_49_1:RecordAudio("321202012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321202", "321202012", "story_v_out_321202.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321202", "321202012", "story_v_out_321202.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_18 and arg_49_1.time_ < var_52_10 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play321202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321202013
		arg_53_1.duration_ = 14.83

		local var_53_0 = {
			zh = 6.133,
			ja = 14.833
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
				arg_53_0:Play321202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos404001ui_story = arg_53_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).z)
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles = arg_53_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_53_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["404001ui_story"].transform.position).z)
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["404001ui_story"].transform.localEulerAngles = arg_53_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["404001ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect404001ui_story == nil then
				arg_53_1.var_.characterEffect404001ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect404001ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect404001ui_story then
				arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["1011ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1011ui_story == nil then
				arg_53_1.var_.characterEffect1011ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect1011ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1011ui_story then
				arg_53_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(321202013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 35 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 35)

				if (35 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 35)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202013", "story_v_out_321202.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202013", "story_v_out_321202.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_321202", "321202013", "story_v_out_321202.awb")

						arg_53_1:RecordAudio("321202013", var_56_13)
						arg_53_1:RecordAudio("321202013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321202", "321202013", "story_v_out_321202.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321202", "321202013", "story_v_out_321202.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play321202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321202014
		arg_57_1.duration_ = 3.8

		local var_57_0 = {
			zh = 3.3,
			ja = 3.8
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1011ui_story"]) and arg_57_1.var_.characterEffect1011ui_story == nil then
				arg_57_1.var_.characterEffect1011ui_story = arg_57_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1011ui_story"]) then
				if arg_57_1.var_.characterEffect1011ui_story and not isNil(arg_57_1.actors_["1011ui_story"]) then
					arg_57_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1011ui_story"]) and arg_57_1.var_.characterEffect1011ui_story then
				arg_57_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["404001ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect404001ui_story == nil then
				arg_57_1.var_.characterEffect404001ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect404001ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_57_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect404001ui_story then
				arg_57_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_57_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_60_4 = 0
			local var_60_5 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(321202014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)

				if (13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202014", "story_v_out_321202.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202014", "story_v_out_321202.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_321202", "321202014", "story_v_out_321202.awb")

						arg_57_1:RecordAudio("321202014", var_60_11)
						arg_57_1:RecordAudio("321202014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321202", "321202014", "story_v_out_321202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321202", "321202014", "story_v_out_321202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321202015
		arg_61_1.duration_ = 10.37

		local var_61_0 = {
			zh = 7,
			ja = 10.366
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
				arg_61_0:Play321202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_0 = 0
			local var_64_1 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(321202015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 29 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 29)

				if (29 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 29)) > 0 and var_64_1 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202015", "story_v_out_321202.awb") ~= 0 then
					local var_64_6 = manager.audio:GetVoiceLength("story_v_out_321202", "321202015", "story_v_out_321202.awb") / 1000

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end

					if var_64_2.prefab_name ~= "" and arg_61_1.actors_[var_64_2.prefab_name] ~= nil then
						local var_64_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_2.prefab_name].transform, "story_v_out_321202", "321202015", "story_v_out_321202.awb")

						arg_61_1:RecordAudio("321202015", var_64_7)
						arg_61_1:RecordAudio("321202015", var_64_7)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321202", "321202015", "story_v_out_321202.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321202", "321202015", "story_v_out_321202.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321202016
		arg_65_1.duration_ = 14.33

		local var_65_0 = {
			zh = 7.333,
			ja = 14.333
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
				arg_65_0:Play321202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["404001ui_story"]) and arg_65_1.var_.characterEffect404001ui_story == nil then
				arg_65_1.var_.characterEffect404001ui_story = arg_65_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["404001ui_story"]) then
				if arg_65_1.var_.characterEffect404001ui_story and not isNil(arg_65_1.actors_["404001ui_story"]) then
					arg_65_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["404001ui_story"]) and arg_65_1.var_.characterEffect404001ui_story then
				arg_65_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1011ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1011ui_story == nil then
				arg_65_1.var_.characterEffect1011ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1011ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1011ui_story then
				arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.9

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(321202016)
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

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202016", "story_v_out_321202.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202016", "story_v_out_321202.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_321202", "321202016", "story_v_out_321202.awb")

						arg_65_1:RecordAudio("321202016", var_68_11)
						arg_65_1:RecordAudio("321202016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321202", "321202016", "story_v_out_321202.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321202", "321202016", "story_v_out_321202.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321202017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos404001ui_story = arg_69_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).z)
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles = arg_69_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["404001ui_story"].transform.position).z)
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["404001ui_story"].transform.localEulerAngles = arg_69_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1011ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1011ui_story = var_72_1.localPosition
			end

			local var_72_2 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_2)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(0, 100, 0)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			local var_72_3 = arg_69_1.actors_["404001ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect404001ui_story == nil then
				arg_69_1.var_.characterEffect404001ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect404001ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_69_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_4)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect404001ui_story then
				arg_69_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_69_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_69_1.time_ and arg_69_1.time_ <= 0.200000002980232 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_140", "se_story_140_work", "")
			end

			local var_72_6 = 0
			local var_72_7 = 0.775

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(321202017).content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 31 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 31)

				if (31 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 31)) > 0 and var_72_7 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_11 and arg_69_1.time_ < var_72_6 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play321202018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321202018
		arg_73_1.duration_ = 11.97

		local var_73_0 = {
			zh = 7.133,
			ja = 11.966
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
				arg_73_0:Play321202019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.9

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(321202018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 36 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 36)

				if (36 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 36)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202018", "story_v_out_321202.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202018", "story_v_out_321202.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_321202", "321202018", "story_v_out_321202.awb")

						arg_73_1:RecordAudio("321202018", var_76_6)
						arg_73_1:RecordAudio("321202018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321202", "321202018", "story_v_out_321202.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321202", "321202018", "story_v_out_321202.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321202019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321202019
		arg_77_1.duration_ = 9.63

		local var_77_0 = {
			zh = 8.466,
			ja = 9.633
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
				arg_77_0:Play321202020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(321202019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 41)

				if (41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 41)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202019", "story_v_out_321202.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202019", "story_v_out_321202.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_321202", "321202019", "story_v_out_321202.awb")

						arg_77_1:RecordAudio("321202019", var_80_6)
						arg_77_1:RecordAudio("321202019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321202", "321202019", "story_v_out_321202.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321202", "321202019", "story_v_out_321202.awb")
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
	Play321202020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321202020
		arg_81_1.duration_ = 5.7

		local var_81_0 = {
			zh = 3.633,
			ja = 5.7
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
				arg_81_0:Play321202021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.475

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(321202020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 19 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 19)

				if (19 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 19)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202020", "story_v_out_321202.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202020", "story_v_out_321202.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_321202", "321202020", "story_v_out_321202.awb")

						arg_81_1:RecordAudio("321202020", var_84_6)
						arg_81_1:RecordAudio("321202020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321202", "321202020", "story_v_out_321202.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321202", "321202020", "story_v_out_321202.awb")
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
	Play321202021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321202021
		arg_85_1.duration_ = 2.93

		local var_85_0 = {
			zh = 2.533,
			ja = 2.933
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
				arg_85_0:Play321202022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos404001ui_story = arg_85_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).z)
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles = arg_85_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_85_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["404001ui_story"].transform.position).z)
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["404001ui_story"].transform.localEulerAngles = arg_85_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["404001ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect404001ui_story == nil then
				arg_85_1.var_.characterEffect404001ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect404001ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect404001ui_story then
				arg_85_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_88_4 = 0
			local var_88_5 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(321202021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 13 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 13)

				if (13 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 13)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202021", "story_v_out_321202.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202021", "story_v_out_321202.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_321202", "321202021", "story_v_out_321202.awb")

						arg_85_1:RecordAudio("321202021", var_88_11)
						arg_85_1:RecordAudio("321202021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321202", "321202021", "story_v_out_321202.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321202", "321202021", "story_v_out_321202.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play321202022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321202022
		arg_89_1.duration_ = 9

		local var_89_0 = {
			zh = 6.366,
			ja = 9
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
				arg_89_0:Play321202023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_92_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_89_1.stage_.transform)

				var_92_0.name = "2079ui_story"
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["2079ui_story"] = var_92_0

				local var_92_1 = var_92_0:GetComponentInChildren(typeof(CharacterEffect))

				var_92_1.enabled = true

				local var_92_2 = GameObjectTools.GetOrAddComponent(var_92_0, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(false)
				end

				arg_89_1:ShowWeapon(var_92_1.transform, false)

				arg_89_1.var_["2079ui_story" .. "Animator"] = var_92_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_89_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_89_1.var_["2079ui_story" .. "LipSync"] = var_92_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_92_3 = arg_89_1.actors_["2079ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos2079ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_4)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(0, 100, 0)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			local var_92_5 = arg_89_1.actors_["404001ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos404001ui_story = var_92_5.localPosition
			end

			local var_92_6 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_89_1.time_ - 0) / var_92_6)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0, -1.55, -5.5)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles
			end

			local var_92_7 = arg_89_1.actors_["404001ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.characterEffect404001ui_story == nil then
				arg_89_1.var_.characterEffect404001ui_story = var_92_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_8 and not isNil(var_92_7) then
				if arg_89_1.var_.characterEffect404001ui_story and not isNil(var_92_7) then
					arg_89_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_89_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_8)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_8 and arg_89_1.time_ < 0 + var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.characterEffect404001ui_story then
				arg_89_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_89_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_92_9 = arg_89_1.actors_["2079ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect2079ui_story == nil then
				arg_89_1.var_.characterEffect2079ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_10 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 and not isNil(var_92_9) then
				if arg_89_1.var_.characterEffect2079ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect2079ui_story then
				arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_92_12 = 0
			local var_92_13 = 0.875

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_14 = arg_89_1:GetWordFromCfg(321202022)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 35 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 35)

				if (35 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 35)) > 0 and var_92_13 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17

					if var_92_17 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202022", "story_v_out_321202.awb") ~= 0 then
					local var_92_18 = manager.audio:GetVoiceLength("story_v_out_321202", "321202022", "story_v_out_321202.awb") / 1000

					if var_92_18 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_12
					end

					if var_92_14.prefab_name ~= "" and arg_89_1.actors_[var_92_14.prefab_name] ~= nil then
						local var_92_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_14.prefab_name].transform, "story_v_out_321202", "321202022", "story_v_out_321202.awb")

						arg_89_1:RecordAudio("321202022", var_92_19)
						arg_89_1:RecordAudio("321202022", var_92_19)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321202", "321202022", "story_v_out_321202.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321202", "321202022", "story_v_out_321202.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_20 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_20 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_20

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_20 and arg_89_1.time_ < var_92_12 + var_92_20 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_89_1:InitPlayNodeList()
	end,
	Play321202023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321202023
		arg_93_1.duration_ = 6.43

		local var_93_0 = {
			zh = 4.6,
			ja = 6.433
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
				arg_93_0:Play321202024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["404001ui_story"]) and arg_93_1.var_.characterEffect404001ui_story == nil then
				arg_93_1.var_.characterEffect404001ui_story = arg_93_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["404001ui_story"]) then
				if arg_93_1.var_.characterEffect404001ui_story and not isNil(arg_93_1.actors_["404001ui_story"]) then
					arg_93_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["404001ui_story"]) and arg_93_1.var_.characterEffect404001ui_story then
				arg_93_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_2 = 0
			local var_96_3 = 0.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(321202023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 22 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 22)

				if (22 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 22)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202023", "story_v_out_321202.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_321202", "321202023", "story_v_out_321202.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_321202", "321202023", "story_v_out_321202.awb")

						arg_93_1:RecordAudio("321202023", var_96_9)
						arg_93_1:RecordAudio("321202023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321202", "321202023", "story_v_out_321202.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321202", "321202023", "story_v_out_321202.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play321202024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321202024
		arg_97_1.duration_ = 5.87

		local var_97_0 = {
			zh = 3.9,
			ja = 5.866
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
				arg_97_0:Play321202025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos404001ui_story = arg_97_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).z)
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles = arg_97_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_97_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).z)
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles = arg_97_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["404001ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect404001ui_story == nil then
				arg_97_1.var_.characterEffect404001ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect404001ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect404001ui_story then
				arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["2079ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect2079ui_story == nil then
				arg_97_1.var_.characterEffect2079ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect2079ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_97_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect2079ui_story then
				arg_97_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_97_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_100_6 = 0
			local var_100_7 = 0.55

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(321202024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 22 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 22)

				if (22 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 22)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202024", "story_v_out_321202.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202024", "story_v_out_321202.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_321202", "321202024", "story_v_out_321202.awb")

						arg_97_1:RecordAudio("321202024", var_100_13)
						arg_97_1:RecordAudio("321202024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321202", "321202024", "story_v_out_321202.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321202", "321202024", "story_v_out_321202.awb")
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
				actorName = "404001ui_story",
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
	Play321202025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321202025
		arg_101_1.duration_ = 6.17

		local var_101_0 = {
			zh = 4.6,
			ja = 6.166
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
				arg_101_0:Play321202026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_104_0 = 0
			local var_104_1 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(321202025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 18 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 18)

				if (18 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 18)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202025", "story_v_out_321202.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_321202", "321202025", "story_v_out_321202.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_321202", "321202025", "story_v_out_321202.awb")

						arg_101_1:RecordAudio("321202025", var_104_7)
						arg_101_1:RecordAudio("321202025", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321202", "321202025", "story_v_out_321202.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321202", "321202025", "story_v_out_321202.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321202026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321202026
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321202027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.L15g == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15g")
				var_108_0.name = "L15g"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.L15g = var_108_0
			end

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.L15g

				arg_105_1.bgs_.L15g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "L15g" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 4

			if 4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_4 + 0.3 and arg_105_1.time_ < var_108_4 + 0.3 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_5 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_6 = 2

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_5) / var_108_6)
				arg_105_1.mask_.color = var_108_7
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 then
				local var_108_8 = Color.New(0, 0, 0)

				var_108_8.a = 1
				arg_105_1.mask_.color = var_108_8
			end

			local var_108_9 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_10 = 2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 then
				local var_108_11 = Color.New(0, 0, 0)

				var_108_11.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_9) / var_108_10)
				arg_105_1.mask_.color = var_108_11
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 then
				local var_108_12 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_12.a = 0
				arg_105_1.mask_.color = var_108_12
			end

			local var_108_13 = arg_105_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_105_1.time_ and arg_105_1.time_ <= 1.96599999815226 + arg_108_0 then
				arg_105_1.var_.moveOldPos404001ui_story = var_108_13.localPosition
			end

			local var_108_14 = 0.001

			if 1.96599999815226 <= arg_105_1.time_ and arg_105_1.time_ < 1.96599999815226 + var_108_14 then
				var_108_13.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 1.96599999815226) / var_108_14)
				var_108_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_13.position).x, (manager.ui.mainCamera.transform.position - var_108_13.position).y, (manager.ui.mainCamera.transform.position - var_108_13.position).z)
				var_108_13.localEulerAngles.z = 0
				var_108_13.localEulerAngles.x = 0
				var_108_13.localEulerAngles = var_108_13.localEulerAngles
			end

			if arg_105_1.time_ >= 1.96599999815226 + var_108_14 and arg_105_1.time_ < 1.96599999815226 + var_108_14 + arg_108_0 then
				var_108_13.localPosition = Vector3.New(0, 100, 0)
				var_108_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_13.position).x, (manager.ui.mainCamera.transform.position - var_108_13.position).y, (manager.ui.mainCamera.transform.position - var_108_13.position).z)
				var_108_13.localEulerAngles.z = 0
				var_108_13.localEulerAngles.x = 0
				var_108_13.localEulerAngles = var_108_13.localEulerAngles
			end

			local var_108_15 = arg_105_1.actors_["2079ui_story"].transform

			if 1.96599999815226 < arg_105_1.time_ and arg_105_1.time_ <= 1.96599999815226 + arg_108_0 then
				arg_105_1.var_.moveOldPos2079ui_story = var_108_15.localPosition
			end

			local var_108_16 = 0.001

			if 1.96599999815226 <= arg_105_1.time_ and arg_105_1.time_ < 1.96599999815226 + var_108_16 then
				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 1.96599999815226) / var_108_16)
				var_108_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_15.position).x, (manager.ui.mainCamera.transform.position - var_108_15.position).y, (manager.ui.mainCamera.transform.position - var_108_15.position).z)
				var_108_15.localEulerAngles.z = 0
				var_108_15.localEulerAngles.x = 0
				var_108_15.localEulerAngles = var_108_15.localEulerAngles
			end

			if arg_105_1.time_ >= 1.96599999815226 + var_108_16 and arg_105_1.time_ < 1.96599999815226 + var_108_16 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0, 100, 0)
				var_108_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_15.position).x, (manager.ui.mainCamera.transform.position - var_108_15.position).y, (manager.ui.mainCamera.transform.position - var_108_15.position).z)
				var_108_15.localEulerAngles.z = 0
				var_108_15.localEulerAngles.x = 0
				var_108_15.localEulerAngles = var_108_15.localEulerAngles
			end

			if 4.13333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 4.13333333333333 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_140", "se_story_140_highway", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_18 = 4
			local var_108_19 = 1.5

			if 4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_20 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_20:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_21 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(321202026).content)

				arg_105_1.text_.text = var_108_21

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_23 = 60 <= 0 and var_108_19 or var_108_19 * (utf8.len(var_108_21) / 60)

				if (60 <= 0 and var_108_19 or var_108_19 * (utf8.len(var_108_21) / 60)) > 0 and var_108_19 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23
					var_108_18 = var_108_18 + 0.3

					if var_108_23 + var_108_18 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_18
					end
				end

				arg_105_1.text_.text = var_108_21
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_24 = var_108_18 + 0.3
			local var_108_25 = math.max(var_108_19, arg_105_1.talkMaxDuration)

			if var_108_18 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_24 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_24) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_24 + var_108_25 and arg_105_1.time_ < var_108_24 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play321202027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321202027
		arg_111_1.duration_ = 6.17

		local var_111_0 = {
			zh = 4.5,
			ja = 6.166
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
				arg_111_0:Play321202028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos404001ui_story = arg_111_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).z)
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles = arg_111_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_111_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["404001ui_story"].transform.position).z)
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["404001ui_story"].transform.localEulerAngles = arg_111_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["404001ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect404001ui_story then
				arg_111_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_114_4 = 0
			local var_114_5 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(321202027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 20 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 20)

				if (20 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 20)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202027", "story_v_out_321202.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202027", "story_v_out_321202.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_321202", "321202027", "story_v_out_321202.awb")

						arg_111_1:RecordAudio("321202027", var_114_11)
						arg_111_1:RecordAudio("321202027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321202", "321202027", "story_v_out_321202.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321202", "321202027", "story_v_out_321202.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play321202028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321202028
		arg_115_1.duration_ = 9.07

		local var_115_0 = {
			zh = 7.3,
			ja = 9.066
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
				arg_115_0:Play321202029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1011ui_story = arg_115_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).z)
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles = arg_115_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_115_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1011ui_story"].transform.position).z)
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1011ui_story"].transform.localEulerAngles = arg_115_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1011ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1011ui_story == nil then
				arg_115_1.var_.characterEffect1011ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1011ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1011ui_story then
				arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_118_4 = arg_115_1.actors_["404001ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect404001ui_story == nil then
				arg_115_1.var_.characterEffect404001ui_story = var_118_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_5 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 and not isNil(var_118_4) then
				if arg_115_1.var_.characterEffect404001ui_story and not isNil(var_118_4) then
					arg_115_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_115_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_5)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect404001ui_story then
				arg_115_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_115_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_118_6 = 0
			local var_118_7 = 0.85

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(321202028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 34 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 34)

				if (34 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 34)) > 0 and var_118_7 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202028", "story_v_out_321202.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202028", "story_v_out_321202.awb") / 1000

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_321202", "321202028", "story_v_out_321202.awb")

						arg_115_1:RecordAudio("321202028", var_118_13)
						arg_115_1:RecordAudio("321202028", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321202", "321202028", "story_v_out_321202.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321202", "321202028", "story_v_out_321202.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play321202029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321202029
		arg_119_1.duration_ = 5.43

		local var_119_0 = {
			zh = 3.7,
			ja = 5.433
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
				arg_119_0:Play321202030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["404001ui_story"]) and arg_119_1.var_.characterEffect404001ui_story == nil then
				arg_119_1.var_.characterEffect404001ui_story = arg_119_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["404001ui_story"]) then
				if arg_119_1.var_.characterEffect404001ui_story and not isNil(arg_119_1.actors_["404001ui_story"]) then
					arg_119_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["404001ui_story"]) and arg_119_1.var_.characterEffect404001ui_story then
				arg_119_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["1011ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect1011ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1011ui_story then
				arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_122_4 = 0
			local var_122_5 = 0.425

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(321202029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 17 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 17)

				if (17 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 17)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202029", "story_v_out_321202.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202029", "story_v_out_321202.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_321202", "321202029", "story_v_out_321202.awb")

						arg_119_1:RecordAudio("321202029", var_122_11)
						arg_119_1:RecordAudio("321202029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_321202", "321202029", "story_v_out_321202.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_321202", "321202029", "story_v_out_321202.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321202030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321202030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321202031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos404001ui_story = arg_123_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).z)
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles = arg_123_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["404001ui_story"].transform.position).z)
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["404001ui_story"].transform.localEulerAngles = arg_123_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1011ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1011ui_story = var_126_1.localPosition
			end

			local var_126_2 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 then
				var_126_1.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_2)
				var_126_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_1.position).x, (manager.ui.mainCamera.transform.position - var_126_1.position).y, (manager.ui.mainCamera.transform.position - var_126_1.position).z)
				var_126_1.localEulerAngles.z = 0
				var_126_1.localEulerAngles.x = 0
				var_126_1.localEulerAngles = var_126_1.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 then
				var_126_1.localPosition = Vector3.New(0, 100, 0)
				var_126_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_1.position).x, (manager.ui.mainCamera.transform.position - var_126_1.position).y, (manager.ui.mainCamera.transform.position - var_126_1.position).z)
				var_126_1.localEulerAngles.z = 0
				var_126_1.localEulerAngles.x = 0
				var_126_1.localEulerAngles = var_126_1.localEulerAngles
			end

			local var_126_3 = arg_123_1.actors_["404001ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect404001ui_story == nil then
				arg_123_1.var_.characterEffect404001ui_story = var_126_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_4 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_3) then
				if arg_123_1.var_.characterEffect404001ui_story and not isNil(var_126_3) then
					arg_123_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_123_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_4)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect404001ui_story then
				arg_123_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_123_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_126_5 = 0
			local var_126_6 = 1.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(321202030).content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 52 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 52)

				if (52 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 52)) > 0 and var_126_6 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_10 and arg_123_1.time_ < var_126_5 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play321202031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321202031
		arg_127_1.duration_ = 3.87

		local var_127_0 = {
			zh = 2.266,
			ja = 3.866
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321202032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1011ui_story = arg_127_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).z)
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles = arg_127_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_127_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1011ui_story"].transform.position).z)
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1011ui_story"].transform.localEulerAngles = arg_127_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1011ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1011ui_story == nil then
				arg_127_1.var_.characterEffect1011ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1011ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1011ui_story then
				arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_4 = 0
			local var_130_5 = 0.3

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(321202031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 12 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 12)

				if (12 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 12)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202031", "story_v_out_321202.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202031", "story_v_out_321202.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_321202", "321202031", "story_v_out_321202.awb")

						arg_127_1:RecordAudio("321202031", var_130_11)
						arg_127_1:RecordAudio("321202031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_321202", "321202031", "story_v_out_321202.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_321202", "321202031", "story_v_out_321202.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play321202032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321202032
		arg_131_1.duration_ = 4

		local var_131_0 = {
			zh = 3.166,
			ja = 4
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321202033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1011ui_story"]) and arg_131_1.var_.characterEffect1011ui_story == nil then
				arg_131_1.var_.characterEffect1011ui_story = arg_131_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1011ui_story"]) then
				if arg_131_1.var_.characterEffect1011ui_story and not isNil(arg_131_1.actors_["1011ui_story"]) then
					arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1011ui_story"]) and arg_131_1.var_.characterEffect1011ui_story then
				arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.275

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(321202032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 11 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 11)

				if (11 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 11)) > 0 and var_134_2 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202032", "story_v_out_321202.awb") ~= 0 then
					local var_134_7 = manager.audio:GetVoiceLength("story_v_out_321202", "321202032", "story_v_out_321202.awb") / 1000

					if var_134_7 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_1
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_321202", "321202032", "story_v_out_321202.awb")

						arg_131_1:RecordAudio("321202032", var_134_8)
						arg_131_1:RecordAudio("321202032", var_134_8)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321202", "321202032", "story_v_out_321202.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321202", "321202032", "story_v_out_321202.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_9 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_9 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_9

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_9 and arg_131_1.time_ < var_134_1 + var_134_9 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321202033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321202033
		arg_135_1.duration_ = 2.77

		local var_135_0 = {
			zh = 1.7,
			ja = 2.766
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321202034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1011ui_story = arg_135_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).z)
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles = arg_135_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_135_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1011ui_story"].transform.position).z)
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1011ui_story"].transform.localEulerAngles = arg_135_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1011ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1011ui_story == nil then
				arg_135_1.var_.characterEffect1011ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1011ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1011ui_story then
				arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_4 = 0
			local var_138_5 = 0.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(321202033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 6 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 6)

				if (6 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 6)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202033", "story_v_out_321202.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202033", "story_v_out_321202.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_321202", "321202033", "story_v_out_321202.awb")

						arg_135_1:RecordAudio("321202033", var_138_11)
						arg_135_1:RecordAudio("321202033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321202", "321202033", "story_v_out_321202.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321202", "321202033", "story_v_out_321202.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play321202034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321202034
		arg_139_1.duration_ = 5.13

		local var_139_0 = {
			zh = 5.133,
			ja = 3.733
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321202035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1011ui_story"]) and arg_139_1.var_.characterEffect1011ui_story == nil then
				arg_139_1.var_.characterEffect1011ui_story = arg_139_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1011ui_story"]) then
				if arg_139_1.var_.characterEffect1011ui_story and not isNil(arg_139_1.actors_["1011ui_story"]) then
					arg_139_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1011ui_story"]) and arg_139_1.var_.characterEffect1011ui_story then
				arg_139_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(321202034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 16 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 16)

				if (16 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 16)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202034", "story_v_out_321202.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_321202", "321202034", "story_v_out_321202.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_321202", "321202034", "story_v_out_321202.awb")

						arg_139_1:RecordAudio("321202034", var_142_8)
						arg_139_1:RecordAudio("321202034", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321202", "321202034", "story_v_out_321202.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321202", "321202034", "story_v_out_321202.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321202035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321202035
		arg_143_1.duration_ = 8.67

		local var_143_0 = {
			zh = 7.4,
			ja = 8.666
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321202036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(321202035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 37 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 37)

				if (37 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 37)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202035", "story_v_out_321202.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202035", "story_v_out_321202.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_321202", "321202035", "story_v_out_321202.awb")

						arg_143_1:RecordAudio("321202035", var_146_6)
						arg_143_1:RecordAudio("321202035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321202", "321202035", "story_v_out_321202.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321202", "321202035", "story_v_out_321202.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321202036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321202036
		arg_147_1.duration_ = 6.57

		local var_147_0 = {
			zh = 4.133,
			ja = 6.566
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
				arg_147_0:Play321202037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.6

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
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

				local var_150_1 = arg_147_1:GetWordFromCfg(321202036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 24 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 24)

				if (24 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 24)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202036", "story_v_out_321202.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202036", "story_v_out_321202.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_321202", "321202036", "story_v_out_321202.awb")

						arg_147_1:RecordAudio("321202036", var_150_6)
						arg_147_1:RecordAudio("321202036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321202", "321202036", "story_v_out_321202.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321202", "321202036", "story_v_out_321202.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321202037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321202037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321202038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.425

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(321202037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 57 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 57)

				if (57 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 57)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321202038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321202038
		arg_155_1.duration_ = 7

		local var_155_0 = {
			zh = 4.866,
			ja = 7
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321202039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos404001ui_story = arg_155_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).z)
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles = arg_155_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_155_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["404001ui_story"].transform.position).z)
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["404001ui_story"].transform.localEulerAngles = arg_155_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1011ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1011ui_story = var_158_1.localPosition
			end

			local var_158_2 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 then
				var_158_1.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_155_1.time_ - 0) / var_158_2)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 then
				var_158_1.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			local var_158_3 = arg_155_1.actors_["404001ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect404001ui_story == nil then
				arg_155_1.var_.characterEffect404001ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect404001ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect404001ui_story then
				arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(321202038)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 22 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 22)

				if (22 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 22)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202038", "story_v_out_321202.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202038", "story_v_out_321202.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_321202", "321202038", "story_v_out_321202.awb")

						arg_155_1:RecordAudio("321202038", var_158_13)
						arg_155_1:RecordAudio("321202038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321202", "321202038", "story_v_out_321202.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321202", "321202038", "story_v_out_321202.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play321202039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321202039
		arg_159_1.duration_ = 7.83

		local var_159_0 = {
			zh = 7.2,
			ja = 7.833
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321202040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1011ui_story = arg_159_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).z)
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles = arg_159_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_159_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1011ui_story"].transform.position).z)
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1011ui_story"].transform.localEulerAngles = arg_159_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1011ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1011ui_story == nil then
				arg_159_1.var_.characterEffect1011ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1011ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1011ui_story then
				arg_159_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["404001ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect404001ui_story == nil then
				arg_159_1.var_.characterEffect404001ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_5 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 and not isNil(var_162_4) then
				if arg_159_1.var_.characterEffect404001ui_story and not isNil(var_162_4) then
					arg_159_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_159_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_5)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect404001ui_story then
				arg_159_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_159_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_6 = 0
			local var_162_7 = 0.825

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(321202039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 33 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 33)

				if (33 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 33)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202039", "story_v_out_321202.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202039", "story_v_out_321202.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_321202", "321202039", "story_v_out_321202.awb")

						arg_159_1:RecordAudio("321202039", var_162_13)
						arg_159_1:RecordAudio("321202039", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321202", "321202039", "story_v_out_321202.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321202", "321202039", "story_v_out_321202.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play321202040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321202040
		arg_163_1.duration_ = 4.17

		local var_163_0 = {
			zh = 2,
			ja = 4.166
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play321202041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos404001ui_story = arg_163_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).z)
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles = arg_163_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_163_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).z)
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles = arg_163_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["404001ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect404001ui_story == nil then
				arg_163_1.var_.characterEffect404001ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect404001ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect404001ui_story then
				arg_163_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["1011ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1011ui_story == nil then
				arg_163_1.var_.characterEffect1011ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_5 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 and not isNil(var_166_4) then
				if arg_163_1.var_.characterEffect1011ui_story and not isNil(var_166_4) then
					arg_163_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_5)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1011ui_story then
				arg_163_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.275

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(321202040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 11 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 11)

				if (11 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 11)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202040", "story_v_out_321202.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_321202", "321202040", "story_v_out_321202.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_321202", "321202040", "story_v_out_321202.awb")

						arg_163_1:RecordAudio("321202040", var_166_13)
						arg_163_1:RecordAudio("321202040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321202", "321202040", "story_v_out_321202.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321202", "321202040", "story_v_out_321202.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play321202041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321202041
		arg_167_1.duration_ = 3.2

		local var_167_0 = {
			zh = 3.2,
			ja = 3.066
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play321202042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) and arg_167_1.var_.characterEffect1011ui_story == nil then
				arg_167_1.var_.characterEffect1011ui_story = arg_167_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) then
				if arg_167_1.var_.characterEffect1011ui_story and not isNil(arg_167_1.actors_["1011ui_story"]) then
					arg_167_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) and arg_167_1.var_.characterEffect1011ui_story then
				arg_167_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_170_2 = arg_167_1.actors_["404001ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect404001ui_story == nil then
				arg_167_1.var_.characterEffect404001ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_3 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.characterEffect404001ui_story and not isNil(var_170_2) then
					arg_167_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_167_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect404001ui_story then
				arg_167_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_167_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_170_4 = 0
			local var_170_5 = 0.2

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(321202041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 8 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 8)

				if (8 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 8)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202041", "story_v_out_321202.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202041", "story_v_out_321202.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_321202", "321202041", "story_v_out_321202.awb")

						arg_167_1:RecordAudio("321202041", var_170_11)
						arg_167_1:RecordAudio("321202041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321202", "321202041", "story_v_out_321202.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321202", "321202041", "story_v_out_321202.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play321202042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321202042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321202043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1011ui_story"]) and arg_171_1.var_.characterEffect1011ui_story == nil then
				arg_171_1.var_.characterEffect1011ui_story = arg_171_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1011ui_story"]) then
				if arg_171_1.var_.characterEffect1011ui_story and not isNil(arg_171_1.actors_["1011ui_story"]) then
					arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1011ui_story"]) and arg_171_1.var_.characterEffect1011ui_story then
				arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_174_1 = arg_171_1.actors_["1011ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1011ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["404001ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos404001ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, 100, 0)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = 0
			local var_174_6 = 1.1

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(321202042).content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 44 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 44)

				if (44 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 44)) > 0 and var_174_6 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_10 and arg_171_1.time_ < var_174_5 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play321202043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321202043
		arg_175_1.duration_ = 8.43

		local var_175_0 = {
			zh = 4.9,
			ja = 8.433
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321202044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.6

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(321202043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 24 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 24)

				if (24 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 24)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202043", "story_v_out_321202.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202043", "story_v_out_321202.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_321202", "321202043", "story_v_out_321202.awb")

						arg_175_1:RecordAudio("321202043", var_178_6)
						arg_175_1:RecordAudio("321202043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321202", "321202043", "story_v_out_321202.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321202", "321202043", "story_v_out_321202.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321202044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321202044
		arg_179_1.duration_ = 5.53

		local var_179_0 = {
			zh = 5,
			ja = 5.533
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321202045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos404001ui_story = arg_179_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).z)
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles = arg_179_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_179_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["404001ui_story"].transform.position).z)
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["404001ui_story"].transform.localEulerAngles = arg_179_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["404001ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect404001ui_story == nil then
				arg_179_1.var_.characterEffect404001ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect404001ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect404001ui_story then
				arg_179_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_182_4 = 0
			local var_182_5 = 0.525

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(321202044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 21 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 21)

				if (21 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 21)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202044", "story_v_out_321202.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_321202", "321202044", "story_v_out_321202.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_321202", "321202044", "story_v_out_321202.awb")

						arg_179_1:RecordAudio("321202044", var_182_11)
						arg_179_1:RecordAudio("321202044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_321202", "321202044", "story_v_out_321202.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_321202", "321202044", "story_v_out_321202.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play321202045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321202045
		arg_183_1.duration_ = 5.88

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321202046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos404001ui_story = arg_183_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).z)
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles = arg_183_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).z)
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles = arg_183_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1011ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1011ui_story = var_186_1.localPosition
			end

			local var_186_2 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 then
				var_186_1.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_2)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 then
				var_186_1.localPosition = Vector3.New(0, 100, 0)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			local var_186_3 = arg_183_1.actors_["404001ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect404001ui_story == nil then
				arg_183_1.var_.characterEffect404001ui_story = var_186_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_4 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 and not isNil(var_186_3) then
				if arg_183_1.var_.characterEffect404001ui_story and not isNil(var_186_3) then
					arg_183_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_183_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_4)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect404001ui_story then
				arg_183_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_183_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_186_5 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_5 + 1.13333333333333 and arg_183_1.time_ < var_186_5 + 1.13333333333333 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			if 0.5 < arg_183_1.time_ and arg_183_1.time_ <= 0.5 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			local var_186_7 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_183_1.time_ and arg_183_1.time_ <= 0.034000001847744 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = var_186_7.localPosition
			end

			local var_186_8 = 0.965999998152256

			if 0.034000001847744 <= arg_183_1.time_ and arg_183_1.time_ < 0.034000001847744 + var_186_8 then
				local var_186_9, var_186_10 = math.modf((arg_183_1.time_ - 0.034000001847744) / 0.066)

				var_186_7.localPosition = Vector3.New(var_186_10 * 0.13, var_186_10 * 0.13, var_186_10 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= 0.034000001847744 + var_186_8 and arg_183_1.time_ < 0.034000001847744 + var_186_8 + arg_186_0 then
				var_186_7.localPosition = arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_11 = 0.875
			local var_186_12 = 1.325

			if 0.875 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_13 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_13:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_14 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(321202045).content)

				arg_183_1.text_.text = var_186_14

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_16 = 53 <= 0 and var_186_12 or var_186_12 * (utf8.len(var_186_14) / 53)

				if (53 <= 0 and var_186_12 or var_186_12 * (utf8.len(var_186_14) / 53)) > 0 and var_186_12 < var_186_16 then
					arg_183_1.talkMaxDuration = var_186_16
					var_186_11 = var_186_11 + 0.3

					if var_186_16 + var_186_11 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_16 + var_186_11
					end
				end

				arg_183_1.text_.text = var_186_14
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_17 = var_186_11 + 0.3
			local var_186_18 = math.max(var_186_12, arg_183_1.talkMaxDuration)

			if var_186_11 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_17 + var_186_18 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_17) / var_186_18

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_17 + var_186_18 and arg_183_1.time_ < var_186_17 + var_186_18 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play321202046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321202046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play321202047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0.466666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 0.466666666666667 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			local var_192_1 = 0
			local var_192_2 = 0.975

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(321202046).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 39 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 39)

				if (39 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 39)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321202047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321202047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321202048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(321202047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 14)

				if (14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 14)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321202048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321202048
		arg_197_1.duration_ = 3.97

		local var_197_0 = {
			zh = 3.3,
			ja = 3.966
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
				arg_197_0:Play321202049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.225

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(321202048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 9 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 9)

				if (9 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 9)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202048", "story_v_out_321202.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202048", "story_v_out_321202.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_321202", "321202048", "story_v_out_321202.awb")

						arg_197_1:RecordAudio("321202048", var_200_6)
						arg_197_1:RecordAudio("321202048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321202", "321202048", "story_v_out_321202.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321202", "321202048", "story_v_out_321202.awb")
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
	Play321202049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321202049
		arg_201_1.duration_ = 9.4

		local var_201_0 = {
			zh = 4.4,
			ja = 9.4
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
				arg_201_0:Play321202050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_9000

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos2079ui_story = arg_201_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).z)
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles = arg_201_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["2079ui_story"].transform.position).z)
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["2079ui_story"].transform.localEulerAngles = arg_201_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_204_1 = "10131ui_story"

			if arg_201_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_204_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_201_1.stage_.transform)

				var_204_2.name = var_204_1
				var_204_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_[var_204_1] = var_204_2

				local var_204_3 = var_204_2:GetComponentInChildren(typeof(CharacterEffect))

				var_204_3.enabled = true

				local var_204_4 = GameObjectTools.GetOrAddComponent(var_204_2, typeof(DynamicBoneHelper))

				if var_204_4 then
					var_204_4:EnableDynamicBone(false)
				end

				arg_201_1:ShowWeapon(var_204_3.transform, false)

				arg_201_1.var_[var_204_1 .. "Animator"] = var_204_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_201_1.var_[var_204_1 .. "Animator"].applyRootMotion = true
				arg_201_1.var_[var_204_1 .. "LipSync"] = var_204_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_204_5 = arg_201_1.actors_["10131ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect10131ui_story == nil then
				arg_201_1.var_.characterEffect10131ui_story = var_204_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.characterEffect10131ui_story and not isNil(var_204_5) then
					arg_201_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect10131ui_story then
				arg_201_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0.275 < arg_201_1.time_ and arg_201_1.time_ <= 0.275 + arg_204_0 then
				local var_204_8 = arg_201_1.var_.effect777

				if not arg_201_1.var_.effect777 then
					var_204_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_204_8.name = "777"
					arg_201_1.var_.effect777 = var_204_8
				else
					var_204_8.transform:SetParent(var_204_9000)
				end

				var_204_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_204_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_204_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_204_0, iter_204_1 in ipairs((var_204_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_204_1.transform.localScale = Vector3.New(iter_204_1.transform.localScale.x / var_204_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_204_1.transform.localScale.y / var_204_10, iter_204_1.transform.localScale.z)
				end
			end

			if 1.324999999999 < arg_201_1.time_ and arg_201_1.time_ <= 1.324999999999 + arg_204_0 then
				if arg_201_1.var_.effect777 then
					Object.Destroy(arg_201_1.var_.effect777)

					arg_201_1.var_.effect777 = nil
				end
			end

			local var_204_13 = 0

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			if arg_201_1.time_ >= var_204_13 + 0.866666666666667 and arg_201_1.time_ < var_204_13 + 0.866666666666667 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_14 = 0
			local var_204_15 = 0.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_201_1.callingController_:SetSelectedState("calling")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_16 = arg_201_1:GetWordFromCfg(321202049)
				local var_204_17 = arg_201_1:FormatText(var_204_16.content)

				arg_201_1.text_.text = var_204_17

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_19 = 11 <= 0 and var_204_15 or var_204_15 * (utf8.len(var_204_17) / 11)

				if (11 <= 0 and var_204_15 or var_204_15 * (utf8.len(var_204_17) / 11)) > 0 and var_204_15 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_14 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_14
					end
				end

				arg_201_1.text_.text = var_204_17
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202049", "story_v_out_321202.awb") ~= 0 then
					local var_204_20 = manager.audio:GetVoiceLength("story_v_out_321202", "321202049", "story_v_out_321202.awb") / 1000

					if var_204_20 + var_204_14 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_20 + var_204_14
					end

					if var_204_16.prefab_name ~= "" and arg_201_1.actors_[var_204_16.prefab_name] ~= nil then
						local var_204_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_16.prefab_name].transform, "story_v_out_321202", "321202049", "story_v_out_321202.awb")

						arg_201_1:RecordAudio("321202049", var_204_21)
						arg_201_1:RecordAudio("321202049", var_204_21)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321202", "321202049", "story_v_out_321202.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321202", "321202049", "story_v_out_321202.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_15, arg_201_1.talkMaxDuration)

			if var_204_14 <= arg_201_1.time_ and arg_201_1.time_ < var_204_14 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_14) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_14 + var_204_22 and arg_201_1.time_ < var_204_14 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play321202050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321202050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321202051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10131ui_story"]) and arg_205_1.var_.characterEffect10131ui_story == nil then
				arg_205_1.var_.characterEffect10131ui_story = arg_205_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10131ui_story"]) then
				if arg_205_1.var_.characterEffect10131ui_story and not isNil(arg_205_1.actors_["10131ui_story"]) then
					arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10131ui_story"]) and arg_205_1.var_.characterEffect10131ui_story then
				arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.825

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(321202050).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 33 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 33)

				if (33 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 33)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321202051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321202051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321202052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.85

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(321202051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 34 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 34)

				if (34 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 34)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321202052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321202052
		arg_213_1.duration_ = 6.7

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321202053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 1.3 < arg_213_1.time_ and arg_213_1.time_ <= 1.3 + arg_216_0 then
				local var_216_0 = arg_213_1.fswbg_.transform:Find("textbox/adapt/content") or arg_213_1.fswbg_.transform:Find("textbox/content")
				local var_216_1 = arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_216_2 = var_216_0:GetComponent("RectTransform")

				var_216_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_216_2.offsetMin = Vector2.New(0, 0)
				var_216_2.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_213_1.time_ and arg_213_1.time_ <= 1.3 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(true)
				arg_213_1.dialog_:SetActive(false)

				arg_213_1.fswtw_.percent = 0
				arg_213_1.fswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(321202052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.fswt_)

				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_213_1.fswtw_:SetDirty()

				arg_213_1.typewritterCharCountI18N = 0

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_3 = 2.3

			if 2.3 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.var_.oldValueTypewriter = arg_213_1.fswtw_.percent

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_4 = 23
			local var_216_5 = 1.53333333333333
			local var_216_6, var_216_7 = arg_213_1:GetPercentByPara(arg_213_1:FormatText(arg_213_1:GetWordFromCfg(321202052).content), 1)

			if var_216_3 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				local var_216_8 = var_216_4 <= 0 and var_216_5 or var_216_5 * ((var_216_7 - arg_213_1.typewritterCharCountI18N) / var_216_4)

				if (var_216_4 <= 0 and var_216_5 or var_216_5 * ((var_216_7 - arg_213_1.typewritterCharCountI18N) / var_216_4)) > 0 and var_216_5 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_3
					end
				end
			end

			local var_216_9 = math.max(1.53333333333333, arg_213_1.talkMaxDuration)

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_9 then
				arg_213_1.fswtw_.percent = Mathf.Lerp(arg_213_1.var_.oldValueTypewriter, var_216_6, (arg_213_1.time_ - var_216_3) / var_216_9)
				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.fswtw_:SetDirty()
			end

			if arg_213_1.time_ >= var_216_3 + var_216_9 and arg_213_1.time_ < var_216_3 + var_216_9 + arg_216_0 then
				arg_213_1.fswtw_.percent = var_216_6

				arg_213_1.fswtw_:SetDirty()
				arg_213_1:ShowNextGo(true)

				arg_213_1.typewritterCharCountI18N = var_216_7
			end

			local var_216_10 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_11 = 1.3

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 then
				local var_216_12 = Color.New(0, 0, 0)

				var_216_12.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_10) / var_216_11)
				arg_213_1.mask_.color = var_216_12
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 then
				local var_216_13 = Color.New(0, 0, 0)

				var_216_13.a = 1
				arg_213_1.mask_.color = var_216_13
			end

			local var_216_14 = 1.3

			if 1.3 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_15 = 2

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_15 then
				local var_216_16 = Color.New(0, 0, 0)

				var_216_16.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_14) / var_216_15)
				arg_213_1.mask_.color = var_216_16
			end

			if arg_213_1.time_ >= var_216_14 + var_216_15 and arg_213_1.time_ < var_216_14 + var_216_15 + arg_216_0 then
				local var_216_17 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_17.a = 0
				arg_213_1.mask_.color = var_216_17
			end

			local var_216_18 = "STblack"

			if arg_213_1.bgs_.STblack == nil then
				local var_216_19 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_216_18)
				var_216_19.name = var_216_18
				var_216_19.transform.parent = arg_213_1.stage_.transform
				var_216_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_[var_216_18] = var_216_19
			end

			if 1.3 < arg_213_1.time_ and arg_213_1.time_ <= 1.3 + arg_216_0 then
				local var_216_20 = arg_213_1.bgs_.STblack

				arg_213_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_21 = var_216_20:GetComponent("SpriteRenderer")

				if var_216_21 and var_216_21.sprite then
					local var_216_22 = 2 * (var_216_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_20.transform.localScale = Vector3.New(var_216_22 / var_216_21.sprite.bounds.size.y < var_216_22 * manager.ui.mainCameraCom_.aspect / var_216_21.sprite.bounds.size.x and var_216_22 * manager.ui.mainCameraCom_.aspect / var_216_21.sprite.bounds.size.x or var_216_22 / var_216_21.sprite.bounds.size.y, var_216_22 / var_216_21.sprite.bounds.size.y < var_216_22 * manager.ui.mainCameraCom_.aspect / var_216_21.sprite.bounds.size.x and var_216_22 * manager.ui.mainCameraCom_.aspect / var_216_21.sprite.bounds.size.x or var_216_22 / var_216_21.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "STblack" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.3 < arg_213_1.time_ and arg_213_1.time_ <= 1.3 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_23 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_23.offsetMin = Vector2.New(400, 105)
				var_216_23.offsetMax = Vector2.New(-400, -200)
				arg_213_1.cswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(419130).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 92
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_216_24 = 2.3
			local var_216_25 = manager.audio:GetVoiceLength("story_v_out_321202", "321202049", "0") / 1000

			if var_216_25 > 0 and 4.4 < var_216_25 and var_216_25 + var_216_24 > arg_213_1.duration_ then
				arg_213_1.duration_ = var_216_25 + var_216_24
			end

			if var_216_24 < arg_213_1.time_ and arg_213_1.time_ <= var_216_24 + arg_216_0 then
				arg_213_1:AudioAction("play", "voice", "story_v_out_321202", "321202049", "0")
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321202053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321202053
		arg_217_1.duration_ = 5.97

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play321202054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 8.88178419700125e-16 < arg_217_1.time_ and arg_217_1.time_ <= 8.88178419700125e-16 + arg_220_0 then
				local var_220_0 = arg_217_1.fswbg_.transform:Find("textbox/adapt/content") or arg_217_1.fswbg_.transform:Find("textbox/content")
				local var_220_1 = arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_220_2 = var_220_0:GetComponent("RectTransform")

				var_220_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_220_2.offsetMin = Vector2.New(0, 0)
				var_220_2.offsetMax = Vector2.New(0, 0)
			end

			if 8.88178419700125e-16 < arg_217_1.time_ and arg_217_1.time_ <= 8.88178419700125e-16 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0
				arg_217_1.fswt_.text = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_3 = 1

			if 1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_4 = 43
			local var_220_5 = 1.53333333333333
			local var_220_6, var_220_7 = arg_217_1:GetPercentByPara(arg_217_1:FormatText(arg_217_1:GetWordFromCfg(102).content), 1)

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_8 = var_220_4 <= 0 and var_220_5 or var_220_5 * ((var_220_7 - arg_217_1.typewritterCharCountI18N) / var_220_4)

				if (var_220_4 <= 0 and var_220_5 or var_220_5 * ((var_220_7 - arg_217_1.typewritterCharCountI18N) / var_220_4)) > 0 and var_220_5 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_3
					end
				end
			end

			local var_220_9 = math.max(1.53333333333333, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_9 then
				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_6, (arg_217_1.time_ - var_220_3) / var_220_9)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_9 and arg_217_1.time_ < var_220_3 + var_220_9 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_6

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_7
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				local var_220_10 = arg_217_1.bgs_.STblack

				arg_217_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_11 = var_220_10:GetComponent("SpriteRenderer")

				if var_220_11 and var_220_11.sprite then
					local var_220_12 = 2 * (var_220_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_10.transform.localScale = Vector3.New(var_220_12 / var_220_11.sprite.bounds.size.y < var_220_12 * manager.ui.mainCameraCom_.aspect / var_220_11.sprite.bounds.size.x and var_220_12 * manager.ui.mainCameraCom_.aspect / var_220_11.sprite.bounds.size.x or var_220_12 / var_220_11.sprite.bounds.size.y, var_220_12 / var_220_11.sprite.bounds.size.y < var_220_12 * manager.ui.mainCameraCom_.aspect / var_220_11.sprite.bounds.size.x and var_220_12 * manager.ui.mainCameraCom_.aspect / var_220_11.sprite.bounds.size.x or var_220_12 / var_220_11.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "STblack" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.cswbg_:SetActive(true)

				local var_220_13 = arg_217_1.cswt_:GetComponent("RectTransform")

				arg_217_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_220_13.offsetMin = Vector2.New(400, 105)
				var_220_13.offsetMax = Vector2.New(-400, -200)
				arg_217_1.cswt_.text = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(419131).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.cswt_)

				arg_217_1.cswt_.fontSize = 92
				arg_217_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_217_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_220_14 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_14 + 3.6 and arg_217_1.time_ < var_220_14 + 3.6 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_15 = 0
			local var_220_16 = manager.audio:GetVoiceLength("story_v_out_321202", "321202053", "0") / 1000

			if var_220_16 > 0 and 5.966 < var_220_16 and var_220_16 + var_220_15 > arg_217_1.duration_ then
				arg_217_1.duration_ = var_220_16 + var_220_15
			end

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1:AudioAction("play", "voice", "story_v_out_321202", "321202053", "0")
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321202054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321202054
		arg_221_1.duration_ = 3.78

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321202055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 8.88178419700125e-16 < arg_221_1.time_ and arg_221_1.time_ <= 8.88178419700125e-16 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(true)
				arg_221_1.dialog_:SetActive(false)

				arg_221_1.fswtw_.percent = 0
				arg_221_1.fswt_.text = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(321202054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.fswt_)

				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_221_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_221_1.fswtw_:SetDirty()

				arg_221_1.typewritterCharCountI18N = 0

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_0 = 0.35

			if 0.35 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.var_.oldValueTypewriter = arg_221_1.fswtw_.percent

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_1 = 14
			local var_224_2 = 0.933333333333333
			local var_224_3, var_224_4 = arg_221_1:GetPercentByPara(arg_221_1:FormatText(arg_221_1:GetWordFromCfg(321202054).content), 1)

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				local var_224_5 = var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)

				if (var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end
			end

			local var_224_6 = math.max(0.933333333333333, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_6 then
				arg_221_1.fswtw_.percent = Mathf.Lerp(arg_221_1.var_.oldValueTypewriter, var_224_3, (arg_221_1.time_ - var_224_0) / var_224_6)
				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_221_1.fswtw_:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_6 and arg_221_1.time_ < var_224_0 + var_224_6 + arg_224_0 then
				arg_221_1.fswtw_.percent = var_224_3

				arg_221_1.fswtw_:SetDirty()
				arg_221_1:ShowNextGo(true)

				arg_221_1.typewritterCharCountI18N = var_224_4
			end

			local var_224_7 = 0.35
			local var_224_8 = manager.audio:GetVoiceLength("story_v_out_321202", "321202054", "0") / 1000

			if var_224_8 > 0 and 3.433 < var_224_8 and var_224_8 + var_224_7 > arg_221_1.duration_ then
				arg_221_1.duration_ = var_224_8 + var_224_7
			end

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1:AudioAction("play", "voice", "story_v_out_321202", "321202054", "0")
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321202055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321202055
		arg_225_1.duration_ = 5.97

		local var_225_0 = {
			zh = 5.966,
			ja = 5.799999999999
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
				arg_225_0:Play321202056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_0 = arg_225_1.bgs_.L15g

				arg_225_1.bgs_.L15g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_1 = var_228_0:GetComponent("SpriteRenderer")

				if var_228_1 and var_228_1.sprite then
					local var_228_2 = 2 * (var_228_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_0.transform.localScale = Vector3.New(var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "L15g" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_3 = 4

			if 4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			if arg_225_1.time_ >= var_228_3 + 0.3 and arg_225_1.time_ < var_228_3 + 0.3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end

			local var_228_4 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_5 = 2

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_5 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = Mathf.Lerp(0, 1, (arg_225_1.time_ - var_228_4) / var_228_5)
				arg_225_1.mask_.color = var_228_6
			end

			if arg_225_1.time_ >= var_228_4 + var_228_5 and arg_225_1.time_ < var_228_4 + var_228_5 + arg_228_0 then
				local var_228_7 = Color.New(0, 0, 0)

				var_228_7.a = 1
				arg_225_1.mask_.color = var_228_7
			end

			local var_228_8 = 2

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_9 = 2

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 then
				local var_228_10 = Color.New(0, 0, 0)

				var_228_10.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_8) / var_228_9)
				arg_225_1.mask_.color = var_228_10
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 then
				local var_228_11 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_11.a = 0
				arg_225_1.mask_.color = var_228_11
			end

			local var_228_12 = arg_225_1.actors_["2079ui_story"].transform

			if 3.8 < arg_225_1.time_ and arg_225_1.time_ <= 3.8 + arg_228_0 then
				arg_225_1.var_.moveOldPos2079ui_story = var_228_12.localPosition
			end

			local var_228_13 = 0.001

			if 3.8 <= arg_225_1.time_ and arg_225_1.time_ < 3.8 + var_228_13 then
				var_228_12.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_225_1.time_ - 3.8) / var_228_13)
				var_228_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_12.position).x, (manager.ui.mainCamera.transform.position - var_228_12.position).y, (manager.ui.mainCamera.transform.position - var_228_12.position).z)
				var_228_12.localEulerAngles.z = 0
				var_228_12.localEulerAngles.x = 0
				var_228_12.localEulerAngles = var_228_12.localEulerAngles
			end

			if arg_225_1.time_ >= 3.8 + var_228_13 and arg_225_1.time_ < 3.8 + var_228_13 + arg_228_0 then
				var_228_12.localPosition = Vector3.New(0, -1.28, -5.6)
				var_228_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_12.position).x, (manager.ui.mainCamera.transform.position - var_228_12.position).y, (manager.ui.mainCamera.transform.position - var_228_12.position).z)
				var_228_12.localEulerAngles.z = 0
				var_228_12.localEulerAngles.x = 0
				var_228_12.localEulerAngles = var_228_12.localEulerAngles
			end

			if 3.8 < arg_225_1.time_ and arg_225_1.time_ <= 3.8 + arg_228_0 then
				arg_225_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 3.8 < arg_225_1.time_ and arg_225_1.time_ <= 3.8 + arg_228_0 then
				arg_225_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_14 = arg_225_1.actors_["2079ui_story"]

			if 3.8 < arg_225_1.time_ and arg_225_1.time_ <= 3.8 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.characterEffect2079ui_story == nil then
				arg_225_1.var_.characterEffect2079ui_story = var_228_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_15 = 0.2

			if 3.8 <= arg_225_1.time_ and arg_225_1.time_ < 3.8 + var_228_15 and not isNil(var_228_14) then
				if arg_225_1.var_.characterEffect2079ui_story and not isNil(var_228_14) then
					arg_225_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 3.8 + var_228_15 and arg_225_1.time_ < 3.8 + var_228_15 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.characterEffect2079ui_story then
				arg_225_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				arg_225_1.cswbg_:SetActive(false)
			end

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(false)
				arg_225_1.dialog_:SetActive(false)
				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			if 2.034 < arg_225_1.time_ and arg_225_1.time_ <= 2.034 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(false)
				arg_225_1.dialog_:SetActive(false)
				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_17 = 4
			local var_228_18 = 0.075

			if 4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_19 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_19:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_20 = arg_225_1:GetWordFromCfg(321202055)
				local var_228_21 = arg_225_1:FormatText(var_228_20.content)

				arg_225_1.text_.text = var_228_21

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_23 = 3 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_21) / 3)

				if (3 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_21) / 3)) > 0 and var_228_18 < var_228_23 then
					arg_225_1.talkMaxDuration = var_228_23
					var_228_17 = var_228_17 + 0.3

					if var_228_23 + var_228_17 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_17
					end
				end

				arg_225_1.text_.text = var_228_21
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202055", "story_v_out_321202.awb") ~= 0 then
					local var_228_24 = manager.audio:GetVoiceLength("story_v_out_321202", "321202055", "story_v_out_321202.awb") / 1000

					if var_228_24 + var_228_17 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_24 + var_228_17
					end

					if var_228_20.prefab_name ~= "" and arg_225_1.actors_[var_228_20.prefab_name] ~= nil then
						local var_228_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_20.prefab_name].transform, "story_v_out_321202", "321202055", "story_v_out_321202.awb")

						arg_225_1:RecordAudio("321202055", var_228_25)
						arg_225_1:RecordAudio("321202055", var_228_25)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321202", "321202055", "story_v_out_321202.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321202", "321202055", "story_v_out_321202.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_26 = var_228_17 + 0.3
			local var_228_27 = math.max(var_228_18, arg_225_1.talkMaxDuration)

			if var_228_17 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_26 + var_228_27 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_26) / var_228_27

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_26 + var_228_27 and arg_225_1.time_ < var_228_26 + var_228_27 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play321202056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321202056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play321202057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["2079ui_story"]) and arg_231_1.var_.characterEffect2079ui_story == nil then
				arg_231_1.var_.characterEffect2079ui_story = arg_231_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["2079ui_story"]) then
				if arg_231_1.var_.characterEffect2079ui_story and not isNil(arg_231_1.actors_["2079ui_story"]) then
					arg_231_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_231_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["2079ui_story"]) and arg_231_1.var_.characterEffect2079ui_story then
				arg_231_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_231_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 1.4

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(321202056).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 56 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 56)

				if (56 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 56)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play321202057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321202057
		arg_235_1.duration_ = 3.4

		local var_235_0 = {
			zh = 2.066,
			ja = 3.4
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
				arg_235_0:Play321202058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_235_1.callingController_:SetSelectedState("calling")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(321202057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 10 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 10)

				if (10 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 10)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202057", "story_v_out_321202.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202057", "story_v_out_321202.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_321202", "321202057", "story_v_out_321202.awb")

						arg_235_1:RecordAudio("321202057", var_238_6)
						arg_235_1:RecordAudio("321202057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_321202", "321202057", "story_v_out_321202.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_321202", "321202057", "story_v_out_321202.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321202058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321202058
		arg_239_1.duration_ = 4.5

		local var_239_0 = {
			zh = 3.066,
			ja = 4.5
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321202059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_242_0 = arg_239_1.actors_["2079ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect2079ui_story == nil then
				arg_239_1.var_.characterEffect2079ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_1 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 and not isNil(var_242_0) then
				if arg_239_1.var_.characterEffect2079ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect2079ui_story then
				arg_239_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_242_3 = 0
			local var_242_4 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_3 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_5 = arg_239_1:GetWordFromCfg(321202058)
				local var_242_6 = arg_239_1:FormatText(var_242_5.content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_8 = 10 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 10)

				if (10 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 10)) > 0 and var_242_4 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8

					if var_242_8 + var_242_3 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_3
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202058", "story_v_out_321202.awb") ~= 0 then
					local var_242_9 = manager.audio:GetVoiceLength("story_v_out_321202", "321202058", "story_v_out_321202.awb") / 1000

					if var_242_9 + var_242_3 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_3
					end

					if var_242_5.prefab_name ~= "" and arg_239_1.actors_[var_242_5.prefab_name] ~= nil then
						local var_242_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_5.prefab_name].transform, "story_v_out_321202", "321202058", "story_v_out_321202.awb")

						arg_239_1:RecordAudio("321202058", var_242_10)
						arg_239_1:RecordAudio("321202058", var_242_10)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_321202", "321202058", "story_v_out_321202.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_321202", "321202058", "story_v_out_321202.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_11 = math.max(var_242_4, arg_239_1.talkMaxDuration)

			if var_242_3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_3 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_3) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_3 + var_242_11 and arg_239_1.time_ < var_242_3 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321202059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321202059
		arg_243_1.duration_ = 6.07

		local var_243_0 = {
			zh = 2.933,
			ja = 6.066
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
				arg_243_0:Play321202060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["2079ui_story"]) and arg_243_1.var_.characterEffect2079ui_story == nil then
				arg_243_1.var_.characterEffect2079ui_story = arg_243_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["2079ui_story"]) then
				if arg_243_1.var_.characterEffect2079ui_story and not isNil(arg_243_1.actors_["2079ui_story"]) then
					arg_243_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_243_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["2079ui_story"]) and arg_243_1.var_.characterEffect2079ui_story then
				arg_243_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_243_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.375

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_243_1.callingController_:SetSelectedState("calling")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(321202059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 15 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 15)

				if (15 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 15)) > 0 and var_246_2 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202059", "story_v_out_321202.awb") ~= 0 then
					local var_246_7 = manager.audio:GetVoiceLength("story_v_out_321202", "321202059", "story_v_out_321202.awb") / 1000

					if var_246_7 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_1
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_321202", "321202059", "story_v_out_321202.awb")

						arg_243_1:RecordAudio("321202059", var_246_8)
						arg_243_1:RecordAudio("321202059", var_246_8)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321202", "321202059", "story_v_out_321202.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321202", "321202059", "story_v_out_321202.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_9 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_9 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_9

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_9 and arg_243_1.time_ < var_246_1 + var_246_9 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play321202060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321202060
		arg_247_1.duration_ = 9.07

		local var_247_0 = {
			zh = 7.9,
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
				arg_247_0:Play321202061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.975

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_247_1.callingController_:SetSelectedState("calling")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(321202060)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 39 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 39)

				if (39 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 39)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202060", "story_v_out_321202.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202060", "story_v_out_321202.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_321202", "321202060", "story_v_out_321202.awb")

						arg_247_1:RecordAudio("321202060", var_250_6)
						arg_247_1:RecordAudio("321202060", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321202", "321202060", "story_v_out_321202.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321202", "321202060", "story_v_out_321202.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play321202061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321202061
		arg_251_1.duration_ = 13.77

		local var_251_0 = {
			zh = 5.633,
			ja = 13.766
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
				arg_251_0:Play321202062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.6

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_251_1.callingController_:SetSelectedState("calling")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(321202061)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 24 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 24)

				if (24 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 24)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202061", "story_v_out_321202.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202061", "story_v_out_321202.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_321202", "321202061", "story_v_out_321202.awb")

						arg_251_1:RecordAudio("321202061", var_254_6)
						arg_251_1:RecordAudio("321202061", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_321202", "321202061", "story_v_out_321202.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_321202", "321202061", "story_v_out_321202.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play321202062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321202062
		arg_255_1.duration_ = 7.6

		local var_255_0 = {
			zh = 3.5,
			ja = 7.6
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321202063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.4

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_255_1.callingController_:SetSelectedState("calling")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(321202062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 16 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 16)

				if (16 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 16)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202062", "story_v_out_321202.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202062", "story_v_out_321202.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_321202", "321202062", "story_v_out_321202.awb")

						arg_255_1:RecordAudio("321202062", var_258_6)
						arg_255_1:RecordAudio("321202062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_321202", "321202062", "story_v_out_321202.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_321202", "321202062", "story_v_out_321202.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play321202063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321202063
		arg_259_1.duration_ = 1.6

		local var_259_0 = {
			zh = 1,
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
				arg_259_0:Play321202064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.15

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1143].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_259_1.callingController_:SetSelectedState("calling")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:GetWordFromCfg(321202063)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 6 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 6)

				if (6 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 6)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202063", "story_v_out_321202.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_321202", "321202063", "story_v_out_321202.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_321202", "321202063", "story_v_out_321202.awb")

						arg_259_1:RecordAudio("321202063", var_262_6)
						arg_259_1:RecordAudio("321202063", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_321202", "321202063", "story_v_out_321202.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_321202", "321202063", "story_v_out_321202.awb")
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
	Play321202064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321202064
		arg_263_1.duration_ = 3.6

		local var_263_0 = {
			zh = 3.6,
			ja = 3.5
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
				arg_263_0:Play321202065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_266_0 = arg_263_1.actors_["2079ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect2079ui_story == nil then
				arg_263_1.var_.characterEffect2079ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_1 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 and not isNil(var_266_0) then
				if arg_263_1.var_.characterEffect2079ui_story and not isNil(var_266_0) then
					arg_263_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect2079ui_story then
				arg_263_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_266_3 = 0
			local var_266_4 = 0.2

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_5 = arg_263_1:GetWordFromCfg(321202064)
				local var_266_6 = arg_263_1:FormatText(var_266_5.content)

				arg_263_1.text_.text = var_266_6

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_8 = 8 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_6) / 8)

				if (8 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_6) / 8)) > 0 and var_266_4 < var_266_8 then
					arg_263_1.talkMaxDuration = var_266_8

					if var_266_8 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_6
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321202", "321202064", "story_v_out_321202.awb") ~= 0 then
					local var_266_9 = manager.audio:GetVoiceLength("story_v_out_321202", "321202064", "story_v_out_321202.awb") / 1000

					if var_266_9 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_3
					end

					if var_266_5.prefab_name ~= "" and arg_263_1.actors_[var_266_5.prefab_name] ~= nil then
						local var_266_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_5.prefab_name].transform, "story_v_out_321202", "321202064", "story_v_out_321202.awb")

						arg_263_1:RecordAudio("321202064", var_266_10)
						arg_263_1:RecordAudio("321202064", var_266_10)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_321202", "321202064", "story_v_out_321202.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_321202", "321202064", "story_v_out_321202.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_11 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_11 and arg_263_1.time_ < var_266_3 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play321202065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 321202065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
			arg_267_1.auto_ = false
		end

		function arg_267_1.playNext_(arg_269_0)
			arg_267_1.onStoryFinished_()
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos2079ui_story = arg_267_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).z)
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles = arg_267_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2079ui_story"].transform.position).z)
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["2079ui_story"].transform.localEulerAngles = arg_267_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_270_1 = 0
			local var_270_2 = 0.9

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(321202065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 36 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 36)

				if (36 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 36)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	assets = {
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/L15g",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_321202.awb"
	}
}
