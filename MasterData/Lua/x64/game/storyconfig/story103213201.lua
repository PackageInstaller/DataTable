return {
	Play321321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321321001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 5.4
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
				arg_1_0:Play321321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08f")
				var_4_0.name = "L08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L08f

				arg_1_1.bgs_.L08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L08f" then
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

			local var_4_9 = "1061ui_story"

			if arg_1_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1061ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1061ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(321321001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)

				if (10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321001", "story_v_out_321321.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_321321", "321321001", "story_v_out_321321.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_321321", "321321001", "story_v_out_321321.awb")

						arg_1_1:RecordAudio("321321001", var_4_33)
						arg_1_1:RecordAudio("321321001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321321", "321321001", "story_v_out_321321.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321321", "321321001", "story_v_out_321321.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321321002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321321002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321321003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061ui_story = arg_9_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1061ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1061ui_story == nil then
				arg_9_1.var_.characterEffect1061ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1061ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1061ui_story then
				arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 1.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321321002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 65 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 65)

				if (65 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 65)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play321321003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321321003
		arg_13_1.duration_ = 3.2

		local var_13_0 = {
			zh = 3.2,
			ja = 2.4
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
				arg_13_0:Play321321004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061ui_story = arg_13_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).z)
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles = arg_13_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_13_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1061ui_story"].transform.position).z)
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1061ui_story"].transform.localEulerAngles = arg_13_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1061ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1061ui_story == nil then
				arg_13_1.var_.characterEffect1061ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1061ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1061ui_story then
				arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_4 = 0
			local var_16_5 = 0.2

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(321321003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 8 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 8)

				if (8 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 8)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321003", "story_v_out_321321.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321003", "story_v_out_321321.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_321321", "321321003", "story_v_out_321321.awb")

						arg_13_1:RecordAudio("321321003", var_16_11)
						arg_13_1:RecordAudio("321321003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321321", "321321003", "story_v_out_321321.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321321", "321321003", "story_v_out_321321.awb")
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

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play321321004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321321004
		arg_17_1.duration_ = 5.43

		local var_17_0 = {
			zh = 4.133,
			ja = 5.433
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
				arg_17_0:Play321321005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1156ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1156ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1156ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1156ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1156ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1156ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.9, -1.1, -6.18)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1061ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			local var_20_7 = arg_17_1.actors_["1156ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1156ui_story == nil then
				arg_17_1.var_.characterEffect1156ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1156ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1156ui_story then
				arg_17_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_20_10 = arg_17_1.actors_["1061ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1061ui_story then
				arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_20_12 = 0
			local var_20_13 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(321321004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 22 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 22)

				if (22 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 22)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321004", "story_v_out_321321.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321004", "story_v_out_321321.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_321321", "321321004", "story_v_out_321321.awb")

						arg_17_1:RecordAudio("321321004", var_20_19)
						arg_17_1:RecordAudio("321321004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321321", "321321004", "story_v_out_321321.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321321", "321321004", "story_v_out_321321.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321321005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321321005
		arg_21_1.duration_ = 3.93

		local var_21_0 = {
			zh = 1.966,
			ja = 3.933
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
				arg_21_0:Play321321006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = arg_21_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) then
				if arg_21_1.var_.characterEffect1061ui_story and not isNil(arg_21_1.actors_["1061ui_story"]) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["1156ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1156ui_story == nil then
				arg_21_1.var_.characterEffect1156ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1156ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1156ui_story then
				arg_21_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.225

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(321321005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 9 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 9)

				if (9 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 9)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321005", "story_v_out_321321.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321005", "story_v_out_321321.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_321321", "321321005", "story_v_out_321321.awb")

						arg_21_1:RecordAudio("321321005", var_24_11)
						arg_21_1:RecordAudio("321321005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321321", "321321005", "story_v_out_321321.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321321", "321321005", "story_v_out_321321.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321321006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321321006
		arg_25_1.duration_ = 2.73

		local var_25_0 = {
			zh = 2.666,
			ja = 2.733
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
				arg_25_0:Play321321007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1156ui_story"]) and arg_25_1.var_.characterEffect1156ui_story == nil then
				arg_25_1.var_.characterEffect1156ui_story = arg_25_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1156ui_story"]) then
				if arg_25_1.var_.characterEffect1156ui_story and not isNil(arg_25_1.actors_["1156ui_story"]) then
					arg_25_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1156ui_story"]) and arg_25_1.var_.characterEffect1156ui_story then
				arg_25_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["1061ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1061ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_28_4 = 0
			local var_28_5 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(321321006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)

				if (9 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 9)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321006", "story_v_out_321321.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321006", "story_v_out_321321.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_321321", "321321006", "story_v_out_321321.awb")

						arg_25_1:RecordAudio("321321006", var_28_11)
						arg_25_1:RecordAudio("321321006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321321", "321321006", "story_v_out_321321.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321321", "321321006", "story_v_out_321321.awb")
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321321007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321321007
		arg_29_1.duration_ = 7.9

		local var_29_0 = {
			zh = 7.9,
			ja = 7.5
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
				arg_29_0:Play321321008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = arg_29_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) then
				if arg_29_1.var_.characterEffect1061ui_story and not isNil(arg_29_1.actors_["1061ui_story"]) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1156ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1156ui_story == nil then
				arg_29_1.var_.characterEffect1156ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1156ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1156ui_story then
				arg_29_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(321321007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 40 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 40)

				if (40 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 40)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321007", "story_v_out_321321.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321007", "story_v_out_321321.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_321321", "321321007", "story_v_out_321321.awb")

						arg_29_1:RecordAudio("321321007", var_32_11)
						arg_29_1:RecordAudio("321321007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321321", "321321007", "story_v_out_321321.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321321", "321321007", "story_v_out_321321.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321321008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321321008
		arg_33_1.duration_ = 10.13

		local var_33_0 = {
			zh = 8.266,
			ja = 10.133
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
				arg_33_0:Play321321009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_0 = 0
			local var_36_1 = 1.025

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(321321008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 41 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 41)

				if (41 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 41)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321008", "story_v_out_321321.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_321321", "321321008", "story_v_out_321321.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_321321", "321321008", "story_v_out_321321.awb")

						arg_33_1:RecordAudio("321321008", var_36_7)
						arg_33_1:RecordAudio("321321008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321321", "321321008", "story_v_out_321321.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321321", "321321008", "story_v_out_321321.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321321009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321321009
		arg_37_1.duration_ = 5.33

		local var_37_0 = {
			zh = 3.633,
			ja = 5.333
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
				arg_37_0:Play321321010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(321321009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 20)

				if (20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 20)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321009", "story_v_out_321321.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321009", "story_v_out_321321.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_321321", "321321009", "story_v_out_321321.awb")

						arg_37_1:RecordAudio("321321009", var_40_6)
						arg_37_1:RecordAudio("321321009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321321", "321321009", "story_v_out_321321.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321321", "321321009", "story_v_out_321321.awb")
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
	Play321321010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321321010
		arg_41_1.duration_ = 6.3

		local var_41_0 = {
			zh = 5.4,
			ja = 6.3
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
				arg_41_0:Play321321011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061ui_story = arg_41_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).z)
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles = arg_41_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_41_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1061ui_story"].transform.position).z)
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1061ui_story"].transform.localEulerAngles = arg_41_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_44_1 = "10104ui_story"

			if arg_41_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_44_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_41_1.stage_.transform)

				var_44_2.name = var_44_1
				var_44_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_[var_44_1] = var_44_2

				local var_44_3 = var_44_2:GetComponentInChildren(typeof(CharacterEffect))

				var_44_3.enabled = true

				local var_44_4 = GameObjectTools.GetOrAddComponent(var_44_2, typeof(DynamicBoneHelper))

				if var_44_4 then
					var_44_4:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_3.transform, false)

				arg_41_1.var_[var_44_1 .. "Animator"] = var_44_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_[var_44_1 .. "Animator"].applyRootMotion = true
				arg_41_1.var_[var_44_1 .. "LipSync"] = var_44_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_5 = arg_41_1.actors_["10104ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = var_44_5.localPosition
			end

			local var_44_6 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_41_1.time_ - 0) / var_44_6)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			local var_44_7 = arg_41_1.actors_["1156ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1156ui_story = var_44_7.localPosition
			end

			local var_44_8 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_8 then
				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_8)
				var_44_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_7.position).x, (manager.ui.mainCamera.transform.position - var_44_7.position).y, (manager.ui.mainCamera.transform.position - var_44_7.position).z)
				var_44_7.localEulerAngles.z = 0
				var_44_7.localEulerAngles.x = 0
				var_44_7.localEulerAngles = var_44_7.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_8 and arg_41_1.time_ < 0 + var_44_8 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(0, 100, 0)
				var_44_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_7.position).x, (manager.ui.mainCamera.transform.position - var_44_7.position).y, (manager.ui.mainCamera.transform.position - var_44_7.position).z)
				var_44_7.localEulerAngles.z = 0
				var_44_7.localEulerAngles.x = 0
				var_44_7.localEulerAngles = var_44_7.localEulerAngles
			end

			local var_44_9 = arg_41_1.actors_["10104ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10104ui_story == nil then
				arg_41_1.var_.characterEffect10104ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_10 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 and not isNil(var_44_9) then
				if arg_41_1.var_.characterEffect10104ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10104ui_story then
				arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_44_12 = arg_41_1.actors_["1061ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.characterEffect1061ui_story == nil then
				arg_41_1.var_.characterEffect1061ui_story = var_44_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_13 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_13 and not isNil(var_44_12) then
				if arg_41_1.var_.characterEffect1061ui_story and not isNil(var_44_12) then
					arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_13)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_13 and arg_41_1.time_ < 0 + var_44_13 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.characterEffect1061ui_story then
				arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_14 = 0
			local var_44_15 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(321321010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 24 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 24)

				if (24 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 24)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321010", "story_v_out_321321.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_321321", "321321010", "story_v_out_321321.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_321321", "321321010", "story_v_out_321321.awb")

						arg_41_1:RecordAudio("321321010", var_44_21)
						arg_41_1:RecordAudio("321321010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321321", "321321010", "story_v_out_321321.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321321", "321321010", "story_v_out_321321.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_15, arg_41_1.talkMaxDuration)

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_22 and arg_41_1.time_ < var_44_14 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play321321011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321321011
		arg_45_1.duration_ = 6.67

		local var_45_0 = {
			zh = 5.5,
			ja = 6.666
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
				arg_45_0:Play321321012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(321321011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)

				if (25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321011", "story_v_out_321321.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321011", "story_v_out_321321.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_321321", "321321011", "story_v_out_321321.awb")

						arg_45_1:RecordAudio("321321011", var_48_6)
						arg_45_1:RecordAudio("321321011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321321", "321321011", "story_v_out_321321.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321321", "321321011", "story_v_out_321321.awb")
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
	Play321321012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321321012
		arg_49_1.duration_ = 11.43

		local var_49_0 = {
			zh = 9.2,
			ja = 11.433
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
				arg_49_0:Play321321013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) and arg_49_1.var_.characterEffect1061ui_story == nil then
				arg_49_1.var_.characterEffect1061ui_story = arg_49_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) then
				if arg_49_1.var_.characterEffect1061ui_story and not isNil(arg_49_1.actors_["1061ui_story"]) then
					arg_49_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) and arg_49_1.var_.characterEffect1061ui_story then
				arg_49_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["10104ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect10104ui_story then
				arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.925

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(321321012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 37 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 37)

				if (37 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 37)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321012", "story_v_out_321321.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321012", "story_v_out_321321.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_321321", "321321012", "story_v_out_321321.awb")

						arg_49_1:RecordAudio("321321012", var_52_11)
						arg_49_1:RecordAudio("321321012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321321", "321321012", "story_v_out_321321.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321321", "321321012", "story_v_out_321321.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321321013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321321013
		arg_53_1.duration_ = 6.5

		local var_53_0 = {
			zh = 5.133,
			ja = 6.5
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
				arg_53_0:Play321321014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061ui_story = arg_53_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).z)
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles = arg_53_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_53_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).z)
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles = arg_53_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10104ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10104ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_3 = 0
			local var_56_4 = 0.725

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:GetWordFromCfg(321321013)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_8 = 29 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_6) / 29)

				if (29 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_6) / 29)) > 0 and var_56_4 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321013", "story_v_out_321321.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_321321", "321321013", "story_v_out_321321.awb") / 1000

					if var_56_9 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_3
					end

					if var_56_5.prefab_name ~= "" and arg_53_1.actors_[var_56_5.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_5.prefab_name].transform, "story_v_out_321321", "321321013", "story_v_out_321321.awb")

						arg_53_1:RecordAudio("321321013", var_56_10)
						arg_53_1:RecordAudio("321321013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321321", "321321013", "story_v_out_321321.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321321", "321321013", "story_v_out_321321.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_11 and arg_53_1.time_ < var_56_3 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play321321014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321321014
		arg_57_1.duration_ = 5.53

		local var_57_0 = {
			zh = 4.6,
			ja = 5.533
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
				arg_57_0:Play321321015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061ui_story = arg_57_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).z)
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles = arg_57_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1061ui_story"].transform.position).z)
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1061ui_story"].transform.localEulerAngles = arg_57_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10104ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10104ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["10104ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10104ui_story == nil then
				arg_57_1.var_.characterEffect10104ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect10104ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10104ui_story then
				arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_60_6 = arg_57_1.actors_["1061ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect1061ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1061ui_story then
				arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_60_8 = 0
			local var_60_9 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(321321014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 22 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 22)

				if (22 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 22)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321014", "story_v_out_321321.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321014", "story_v_out_321321.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_321321", "321321014", "story_v_out_321321.awb")

						arg_57_1:RecordAudio("321321014", var_60_15)
						arg_57_1:RecordAudio("321321014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321321", "321321014", "story_v_out_321321.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321321", "321321014", "story_v_out_321321.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play321321015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321321015
		arg_61_1.duration_ = 1.2

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 1.2
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
				arg_61_0:Play321321016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_64_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_61_1.stage_.transform)

				var_64_0.name = "2078ui_story"
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["2078ui_story"] = var_64_0

				local var_64_1 = var_64_0:GetComponentInChildren(typeof(CharacterEffect))

				var_64_1.enabled = true

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end

				arg_61_1:ShowWeapon(var_64_1.transform, false)

				arg_61_1.var_["2078ui_story" .. "Animator"] = var_64_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_61_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_61_1.var_["2078ui_story" .. "LipSync"] = var_64_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_64_3 = arg_61_1.actors_["2078ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos2078ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["10104ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10104ui_story = var_64_5.localPosition
			end

			local var_64_6 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_6)
				var_64_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_5.position).x, (manager.ui.mainCamera.transform.position - var_64_5.position).y, (manager.ui.mainCamera.transform.position - var_64_5.position).z)
				var_64_5.localEulerAngles.z = 0
				var_64_5.localEulerAngles.x = 0
				var_64_5.localEulerAngles = var_64_5.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, 100, 0)
				var_64_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_5.position).x, (manager.ui.mainCamera.transform.position - var_64_5.position).y, (manager.ui.mainCamera.transform.position - var_64_5.position).z)
				var_64_5.localEulerAngles.z = 0
				var_64_5.localEulerAngles.x = 0
				var_64_5.localEulerAngles = var_64_5.localEulerAngles
			end

			local var_64_7 = arg_61_1.actors_["2078ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect2078ui_story == nil then
				arg_61_1.var_.characterEffect2078ui_story = var_64_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_8 and not isNil(var_64_7) then
				if arg_61_1.var_.characterEffect2078ui_story and not isNil(var_64_7) then
					arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_8 and arg_61_1.time_ < 0 + var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect2078ui_story then
				arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_64_10 = arg_61_1.actors_["10104ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10104ui_story == nil then
				arg_61_1.var_.characterEffect10104ui_story = var_64_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_11 and not isNil(var_64_10) then
				if arg_61_1.var_.characterEffect10104ui_story and not isNil(var_64_10) then
					arg_61_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_11)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_11 and arg_61_1.time_ < 0 + var_64_11 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10104ui_story then
				arg_61_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_12 = 0
			local var_64_13 = 0.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1175].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(321321015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 3 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 3)

				if (3 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 3)) > 0 and var_64_13 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321015", "story_v_out_321321.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321015", "story_v_out_321321.awb") / 1000

					if var_64_18 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_12
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_321321", "321321015", "story_v_out_321321.awb")

						arg_61_1:RecordAudio("321321015", var_64_19)
						arg_61_1:RecordAudio("321321015", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321321", "321321015", "story_v_out_321321.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321321", "321321015", "story_v_out_321321.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_20 and arg_61_1.time_ < var_64_12 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play321321016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321321016
		arg_65_1.duration_ = 7.1

		local var_65_0 = {
			zh = 6.733,
			ja = 7.1
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
				arg_65_0:Play321321017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10104ui_story = arg_65_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).z)
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles = arg_65_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_65_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10104ui_story"].transform.position).z)
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10104ui_story"].transform.localEulerAngles = arg_65_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["2078ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos2078ui_story = var_68_1.localPosition
			end

			local var_68_2 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_2)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 then
				var_68_1.localPosition = Vector3.New(0, 100, 0)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			local var_68_3 = arg_65_1.actors_["10104ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10104ui_story == nil then
				arg_65_1.var_.characterEffect10104ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10104ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10104ui_story then
				arg_65_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_68_6 = arg_65_1.actors_["2078ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2078ui_story == nil then
				arg_65_1.var_.characterEffect2078ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect2078ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2078ui_story then
				arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_68_8 = 0
			local var_68_9 = 0.8

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(321321016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 32 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 32)

				if (32 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 32)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321016", "story_v_out_321321.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321016", "story_v_out_321321.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_321321", "321321016", "story_v_out_321321.awb")

						arg_65_1:RecordAudio("321321016", var_68_15)
						arg_65_1:RecordAudio("321321016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321321", "321321016", "story_v_out_321321.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321321", "321321016", "story_v_out_321321.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_65_1:InitPlayNodeList()
	end,
	Play321321017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321321017
		arg_69_1.duration_ = 1.23

		local var_69_0 = {
			zh = 1.233,
			ja = 0.999999999999
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
				arg_69_0:Play321321018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) and arg_69_1.var_.characterEffect10104ui_story == nil then
				arg_69_1.var_.characterEffect10104ui_story = arg_69_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) then
				if arg_69_1.var_.characterEffect10104ui_story and not isNil(arg_69_1.actors_["10104ui_story"]) then
					arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) and arg_69_1.var_.characterEffect10104ui_story then
				arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(321321017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 5 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 5)

				if (5 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 5)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321017", "story_v_out_321321.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_321321", "321321017", "story_v_out_321321.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_321321", "321321017", "story_v_out_321321.awb")

						arg_69_1:RecordAudio("321321017", var_72_8)
						arg_69_1:RecordAudio("321321017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321321", "321321017", "story_v_out_321321.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321321", "321321017", "story_v_out_321321.awb")
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
	Play321321018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321321018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321321019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10104ui_story = arg_73_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).z)
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles = arg_73_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).z)
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles = arg_73_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0.133333333333333 < arg_73_1.time_ and arg_73_1.time_ <= 0.133333333333333 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_soldier", "")
			end

			local var_76_2 = 0
			local var_76_3 = 0.8

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(321321018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 32 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 32)

				if (32 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 32)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play321321019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321321019
		arg_77_1.duration_ = 11.83

		local var_77_0 = {
			zh = 7.733,
			ja = 11.833
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
				arg_77_0:Play321321020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10104ui_story = arg_77_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).z)
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles = arg_77_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_77_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10104ui_story"].transform.position).z)
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10104ui_story"].transform.localEulerAngles = arg_77_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10104ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10104ui_story == nil then
				arg_77_1.var_.characterEffect10104ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10104ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10104ui_story then
				arg_77_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_4 = 0
			local var_80_5 = 0.8

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(321321019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 32 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 32)

				if (32 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 32)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321019", "story_v_out_321321.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321019", "story_v_out_321321.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_321321", "321321019", "story_v_out_321321.awb")

						arg_77_1:RecordAudio("321321019", var_80_11)
						arg_77_1:RecordAudio("321321019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321321", "321321019", "story_v_out_321321.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321321", "321321019", "story_v_out_321321.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play321321020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321321020
		arg_81_1.duration_ = 9.93

		local var_81_0 = {
			zh = 8.8,
			ja = 9.933
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
				arg_81_0:Play321321021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.05

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(321321020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 42 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 42)

				if (42 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 42)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321020", "story_v_out_321321.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321020", "story_v_out_321321.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_321321", "321321020", "story_v_out_321321.awb")

						arg_81_1:RecordAudio("321321020", var_84_6)
						arg_81_1:RecordAudio("321321020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321321", "321321020", "story_v_out_321321.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321321", "321321020", "story_v_out_321321.awb")
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
	Play321321021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321321021
		arg_85_1.duration_ = 6.5

		local var_85_0 = {
			zh = 6,
			ja = 6.5
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
				arg_85_0:Play321321022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.725

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(321321021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 29 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 29)

				if (29 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 29)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321021", "story_v_out_321321.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321021", "story_v_out_321321.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_321321", "321321021", "story_v_out_321321.awb")

						arg_85_1:RecordAudio("321321021", var_88_6)
						arg_85_1:RecordAudio("321321021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321321", "321321021", "story_v_out_321321.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321321", "321321021", "story_v_out_321321.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play321321022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321321022
		arg_89_1.duration_ = 10.67

		local var_89_0 = {
			zh = 6.833,
			ja = 10.666
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
				arg_89_0:Play321321023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10104ui_story = arg_89_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).z)
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles = arg_89_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_89_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10104ui_story"].transform.position).z)
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10104ui_story"].transform.localEulerAngles = arg_89_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_92_1 = 0
			local var_92_2 = 0.825

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(321321022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 33 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 33)

				if (33 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 33)) > 0 and var_92_2 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321022", "story_v_out_321321.awb") ~= 0 then
					local var_92_7 = manager.audio:GetVoiceLength("story_v_out_321321", "321321022", "story_v_out_321321.awb") / 1000

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_321321", "321321022", "story_v_out_321321.awb")

						arg_89_1:RecordAudio("321321022", var_92_8)
						arg_89_1:RecordAudio("321321022", var_92_8)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321321", "321321022", "story_v_out_321321.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321321", "321321022", "story_v_out_321321.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_9 and arg_89_1.time_ < var_92_1 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play321321023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321321023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321321024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10104ui_story = arg_93_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).z)
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles = arg_93_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).z)
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles = arg_93_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10104ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10104ui_story == nil then
				arg_93_1.var_.characterEffect10104ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10104ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_2)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10104ui_story then
				arg_93_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_96_3 = 0
			local var_96_4 = 1.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(321321023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 62 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 62)

				if (62 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 62)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play321321024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321321024
		arg_97_1.duration_ = 16.97

		local var_97_0 = {
			zh = 10,
			ja = 16.966
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
				arg_97_0:Play321321025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10104ui_story = arg_97_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).z)
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles = arg_97_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_97_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10104ui_story"].transform.position).z)
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10104ui_story"].transform.localEulerAngles = arg_97_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10104ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10104ui_story == nil then
				arg_97_1.var_.characterEffect10104ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10104ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10104ui_story then
				arg_97_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104actionlink/10104action426")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 1.2

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(321321024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 48 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 48)

				if (48 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 48)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321024", "story_v_out_321321.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321024", "story_v_out_321321.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_321321", "321321024", "story_v_out_321321.awb")

						arg_97_1:RecordAudio("321321024", var_100_11)
						arg_97_1:RecordAudio("321321024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321321", "321321024", "story_v_out_321321.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321321", "321321024", "story_v_out_321321.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play321321025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321321025
		arg_101_1.duration_ = 13.8

		local var_101_0 = {
			zh = 11.666,
			ja = 13.8
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
				arg_101_0:Play321321026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.025

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(321321025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 41 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 41)

				if (41 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 41)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321025", "story_v_out_321321.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321025", "story_v_out_321321.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_321321", "321321025", "story_v_out_321321.awb")

						arg_101_1:RecordAudio("321321025", var_104_6)
						arg_101_1:RecordAudio("321321025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321321", "321321025", "story_v_out_321321.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321321", "321321025", "story_v_out_321321.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321321026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321321026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321321027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10104ui_story = arg_105_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).z)
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles = arg_105_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10104ui_story"].transform.position).z)
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10104ui_story"].transform.localEulerAngles = arg_105_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10104ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10104ui_story == nil then
				arg_105_1.var_.characterEffect10104ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10104ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10104ui_story then
				arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_108_3 = 0
			local var_108_4 = 0.975

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(321321026).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 39 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 39)

				if (39 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 39)) > 0 and var_108_4 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_8 and arg_105_1.time_ < var_108_3 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play321321027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321321027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321321028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321321027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 40 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 40)

				if (40 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 40)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321321028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321321028
		arg_113_1.duration_ = 10

		local var_113_0 = {
			zh = 7.5,
			ja = 10
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
				arg_113_0:Play321321029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = arg_113_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).z)
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles = arg_113_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_113_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).z)
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles = arg_113_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10104ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_116_4 = 0
			local var_116_5 = 0.975

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(321321028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 39 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 39)

				if (39 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 39)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321028", "story_v_out_321321.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321028", "story_v_out_321321.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_321321", "321321028", "story_v_out_321321.awb")

						arg_113_1:RecordAudio("321321028", var_116_11)
						arg_113_1:RecordAudio("321321028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321321", "321321028", "story_v_out_321321.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321321", "321321028", "story_v_out_321321.awb")
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
				actorName = "10104ui_story",
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
	Play321321029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321321029
		arg_117_1.duration_ = 9.37

		local var_117_0 = {
			zh = 8.066,
			ja = 9.366
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
				arg_117_0:Play321321030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10104ui_story = arg_117_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).z)
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles = arg_117_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_117_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).z)
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles = arg_117_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_120_1 = "1211ui_story"

			if arg_117_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_120_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_117_1.stage_.transform)

				var_120_2.name = var_120_1
				var_120_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_[var_120_1] = var_120_2

				local var_120_3 = var_120_2:GetComponentInChildren(typeof(CharacterEffect))

				var_120_3.enabled = true

				local var_120_4 = GameObjectTools.GetOrAddComponent(var_120_2, typeof(DynamicBoneHelper))

				if var_120_4 then
					var_120_4:EnableDynamicBone(false)
				end

				arg_117_1:ShowWeapon(var_120_3.transform, false)

				arg_117_1.var_[var_120_1 .. "Animator"] = var_120_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_117_1.var_[var_120_1 .. "Animator"].applyRootMotion = true
				arg_117_1.var_[var_120_1 .. "LipSync"] = var_120_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_120_5 = arg_117_1.actors_["1211ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1211ui_story = var_120_5.localPosition
			end

			local var_120_6 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 then
				var_120_5.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_117_1.time_ - 0) / var_120_6)
				var_120_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_5.position).x, (manager.ui.mainCamera.transform.position - var_120_5.position).y, (manager.ui.mainCamera.transform.position - var_120_5.position).z)
				var_120_5.localEulerAngles.z = 0
				var_120_5.localEulerAngles.x = 0
				var_120_5.localEulerAngles = var_120_5.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 then
				var_120_5.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_120_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_5.position).x, (manager.ui.mainCamera.transform.position - var_120_5.position).y, (manager.ui.mainCamera.transform.position - var_120_5.position).z)
				var_120_5.localEulerAngles.z = 0
				var_120_5.localEulerAngles.x = 0
				var_120_5.localEulerAngles = var_120_5.localEulerAngles
			end

			local var_120_7 = arg_117_1.actors_["1211ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect1211ui_story == nil then
				arg_117_1.var_.characterEffect1211ui_story = var_120_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_8 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_8 and not isNil(var_120_7) then
				if arg_117_1.var_.characterEffect1211ui_story and not isNil(var_120_7) then
					arg_117_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_8 and arg_117_1.time_ < 0 + var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect1211ui_story then
				arg_117_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_120_10 = arg_117_1.actors_["10104ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = var_120_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_11 and not isNil(var_120_10) then
				if arg_117_1.var_.characterEffect10104ui_story and not isNil(var_120_10) then
					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_11)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_11 and arg_117_1.time_ < 0 + var_120_11 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect10104ui_story then
				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_120_12 = 0
			local var_120_13 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(321321029)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 45 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 45)

				if (45 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 45)) > 0 and var_120_13 < var_120_17 then
					arg_117_1.talkMaxDuration = var_120_17

					if var_120_17 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321029", "story_v_out_321321.awb") ~= 0 then
					local var_120_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321029", "story_v_out_321321.awb") / 1000

					if var_120_18 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_12
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_321321", "321321029", "story_v_out_321321.awb")

						arg_117_1:RecordAudio("321321029", var_120_19)
						arg_117_1:RecordAudio("321321029", var_120_19)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321321", "321321029", "story_v_out_321321.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321321", "321321029", "story_v_out_321321.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_20 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_20 and arg_117_1.time_ < var_120_12 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_117_1:InitPlayNodeList()
	end,
	Play321321030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321321030
		arg_121_1.duration_ = 7.2

		local var_121_0 = {
			zh = 5.8,
			ja = 7.2
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
				arg_121_0:Play321321031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10104ui_story"]) and arg_121_1.var_.characterEffect10104ui_story == nil then
				arg_121_1.var_.characterEffect10104ui_story = arg_121_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10104ui_story"]) then
				if arg_121_1.var_.characterEffect10104ui_story and not isNil(arg_121_1.actors_["10104ui_story"]) then
					arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10104ui_story"]) and arg_121_1.var_.characterEffect10104ui_story then
				arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1211ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1211ui_story == nil then
				arg_121_1.var_.characterEffect1211ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1211ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1211ui_story then
				arg_121_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(321321030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 29 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 29)

				if (29 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 29)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321030", "story_v_out_321321.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321030", "story_v_out_321321.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_321321", "321321030", "story_v_out_321321.awb")

						arg_121_1:RecordAudio("321321030", var_124_11)
						arg_121_1:RecordAudio("321321030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321321", "321321030", "story_v_out_321321.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321321", "321321030", "story_v_out_321321.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play321321031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321321031
		arg_125_1.duration_ = 2.97

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_125_0:Play321321032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10104ui_story = arg_125_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).z)
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles = arg_125_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_125_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10104ui_story"].transform.position).z)
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10104ui_story"].transform.localEulerAngles = arg_125_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1211ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1211ui_story = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_2)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, 100, 0)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			local var_128_3 = arg_125_1.actors_["1061ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1061ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1061ui_story == nil then
				arg_125_1.var_.characterEffect1061ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1061ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1061ui_story then
				arg_125_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_128_8 = arg_125_1.actors_["10104ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_9 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_8) then
					arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_9)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect10104ui_story then
				arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_10 = 0
			local var_128_11 = 0.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_12 = arg_125_1:GetWordFromCfg(321321031)
				local var_128_13 = arg_125_1:FormatText(var_128_12.content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 7 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 7)

				if (7 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 7)) > 0 and var_128_11 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321031", "story_v_out_321321.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_out_321321", "321321031", "story_v_out_321321.awb") / 1000

					if var_128_16 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_10
					end

					if var_128_12.prefab_name ~= "" and arg_125_1.actors_[var_128_12.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_12.prefab_name].transform, "story_v_out_321321", "321321031", "story_v_out_321321.awb")

						arg_125_1:RecordAudio("321321031", var_128_17)
						arg_125_1:RecordAudio("321321031", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321321", "321321031", "story_v_out_321321.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321321", "321321031", "story_v_out_321321.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_18 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_18

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_18 and arg_125_1.time_ < var_128_10 + var_128_18 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_125_1:InitPlayNodeList()
	end,
	Play321321032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321321032
		arg_129_1.duration_ = 1.73

		local var_129_0 = {
			zh = 1.166,
			ja = 1.733
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
				arg_129_0:Play321321033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10104ui_story = arg_129_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).z)
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles = arg_129_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_129_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10104ui_story"].transform.position).z)
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10104ui_story"].transform.localEulerAngles = arg_129_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1061ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1061ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			local var_132_3 = arg_129_1.actors_["10104ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect10104ui_story == nil then
				arg_129_1.var_.characterEffect10104ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect10104ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect10104ui_story then
				arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_132_6 = arg_129_1.actors_["1061ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1061ui_story == nil then
				arg_129_1.var_.characterEffect1061ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 and not isNil(var_132_6) then
				if arg_129_1.var_.characterEffect1061ui_story and not isNil(var_132_6) then
					arg_129_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_7)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1061ui_story then
				arg_129_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_132_8 = 0
			local var_132_9 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(321321032)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 5 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 5)

				if (5 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 5)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321032", "story_v_out_321321.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321032", "story_v_out_321321.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_321321", "321321032", "story_v_out_321321.awb")

						arg_129_1:RecordAudio("321321032", var_132_15)
						arg_129_1:RecordAudio("321321032", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321321", "321321032", "story_v_out_321321.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321321", "321321032", "story_v_out_321321.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_129_1:InitPlayNodeList()
	end,
	Play321321033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321321033
		arg_133_1.duration_ = 4.97

		local var_133_0 = {
			zh = 3.233,
			ja = 4.966
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
				arg_133_0:Play321321034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) and arg_133_1.var_.characterEffect1061ui_story == nil then
				arg_133_1.var_.characterEffect1061ui_story = arg_133_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) then
				if arg_133_1.var_.characterEffect1061ui_story and not isNil(arg_133_1.actors_["1061ui_story"]) then
					arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1061ui_story"]) and arg_133_1.var_.characterEffect1061ui_story then
				arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["10104ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10104ui_story == nil then
				arg_133_1.var_.characterEffect10104ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect10104ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10104ui_story then
				arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.3

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(321321033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 12 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 12)

				if (12 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 12)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321033", "story_v_out_321321.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321033", "story_v_out_321321.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_321321", "321321033", "story_v_out_321321.awb")

						arg_133_1:RecordAudio("321321033", var_136_11)
						arg_133_1:RecordAudio("321321033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321321", "321321033", "story_v_out_321321.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321321", "321321033", "story_v_out_321321.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321321034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321321034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321321035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.bgs_.L11f == nil then
				local var_140_0 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L11f")
				var_140_0.name = "L11f"
				var_140_0.transform.parent = arg_137_1.stage_.transform
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_.L11f = var_140_0
			end

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_1 = arg_137_1.bgs_.L11f

				arg_137_1.bgs_.L11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_2 = var_140_1:GetComponent("SpriteRenderer")

				if var_140_2 and var_140_2.sprite then
					local var_140_3 = 2 * (var_140_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_1.transform.localScale = Vector3.New(var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "L11f" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_4 = 3.999999999999

			if 3.999999999999 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_4 + 0.3 and arg_137_1.time_ < var_140_4 + 0.3 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_5 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_6 = 2

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 then
				local var_140_7 = Color.New(0, 0, 0)

				var_140_7.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_5) / var_140_6)
				arg_137_1.mask_.color = var_140_7
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 then
				local var_140_8 = Color.New(0, 0, 0)

				var_140_8.a = 1
				arg_137_1.mask_.color = var_140_8
			end

			local var_140_9 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_10 = 2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 then
				local var_140_11 = Color.New(0, 0, 0)

				var_140_11.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_9) / var_140_10)
				arg_137_1.mask_.color = var_140_11
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 then
				local var_140_12 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_12.a = 0
				arg_137_1.mask_.color = var_140_12
			end

			local var_140_13 = arg_137_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_137_1.time_ and arg_137_1.time_ <= 1.96599999815226 + arg_140_0 then
				arg_137_1.var_.moveOldPos10104ui_story = var_140_13.localPosition
			end

			local var_140_14 = 0.001

			if 1.96599999815226 <= arg_137_1.time_ and arg_137_1.time_ < 1.96599999815226 + var_140_14 then
				var_140_13.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 1.96599999815226) / var_140_14)
				var_140_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_13.position).x, (manager.ui.mainCamera.transform.position - var_140_13.position).y, (manager.ui.mainCamera.transform.position - var_140_13.position).z)
				var_140_13.localEulerAngles.z = 0
				var_140_13.localEulerAngles.x = 0
				var_140_13.localEulerAngles = var_140_13.localEulerAngles
			end

			if arg_137_1.time_ >= 1.96599999815226 + var_140_14 and arg_137_1.time_ < 1.96599999815226 + var_140_14 + arg_140_0 then
				var_140_13.localPosition = Vector3.New(0, 100, 0)
				var_140_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_13.position).x, (manager.ui.mainCamera.transform.position - var_140_13.position).y, (manager.ui.mainCamera.transform.position - var_140_13.position).z)
				var_140_13.localEulerAngles.z = 0
				var_140_13.localEulerAngles.x = 0
				var_140_13.localEulerAngles = var_140_13.localEulerAngles
			end

			local var_140_15 = arg_137_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_137_1.time_ and arg_137_1.time_ <= 1.96599999815226 + arg_140_0 then
				arg_137_1.var_.moveOldPos1061ui_story = var_140_15.localPosition
			end

			local var_140_16 = 0.001

			if 1.96599999815226 <= arg_137_1.time_ and arg_137_1.time_ < 1.96599999815226 + var_140_16 then
				var_140_15.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 1.96599999815226) / var_140_16)
				var_140_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_15.position).x, (manager.ui.mainCamera.transform.position - var_140_15.position).y, (manager.ui.mainCamera.transform.position - var_140_15.position).z)
				var_140_15.localEulerAngles.z = 0
				var_140_15.localEulerAngles.x = 0
				var_140_15.localEulerAngles = var_140_15.localEulerAngles
			end

			if arg_137_1.time_ >= 1.96599999815226 + var_140_16 and arg_137_1.time_ < 1.96599999815226 + var_140_16 + arg_140_0 then
				var_140_15.localPosition = Vector3.New(0, 100, 0)
				var_140_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_15.position).x, (manager.ui.mainCamera.transform.position - var_140_15.position).y, (manager.ui.mainCamera.transform.position - var_140_15.position).z)
				var_140_15.localEulerAngles.z = 0
				var_140_15.localEulerAngles.x = 0
				var_140_15.localEulerAngles = var_140_15.localEulerAngles
			end

			local var_140_17 = arg_137_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_137_1.time_ and arg_137_1.time_ <= 1.96599999815226 + arg_140_0 and not isNil(var_140_17) and arg_137_1.var_.characterEffect1061ui_story == nil then
				arg_137_1.var_.characterEffect1061ui_story = var_140_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_18 = 0.034000001847744

			if 1.96599999815226 <= arg_137_1.time_ and arg_137_1.time_ < 1.96599999815226 + var_140_18 and not isNil(var_140_17) then
				if arg_137_1.var_.characterEffect1061ui_story and not isNil(var_140_17) then
					arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 1.96599999815226) / var_140_18)
				end
			end

			if arg_137_1.time_ >= 1.96599999815226 + var_140_18 and arg_137_1.time_ < 1.96599999815226 + var_140_18 + arg_140_0 and not isNil(var_140_17) and arg_137_1.var_.characterEffect1061ui_story then
				arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_140_19 = arg_137_1.bgs_.L11f.transform

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				arg_137_1.var_.moveOldPosL11f = var_140_19.localPosition
			end

			local var_140_20 = 4

			if 2 <= arg_137_1.time_ and arg_137_1.time_ < 2 + var_140_20 then
				var_140_19.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosL11f, Vector3.New(0, 1, 9.5), (arg_137_1.time_ - 2) / var_140_20)
			end

			if arg_137_1.time_ >= 2 + var_140_20 and arg_137_1.time_ < 2 + var_140_20 + arg_140_0 then
				var_140_19.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_140_21 = 4

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_21 + 2 and arg_137_1.time_ < var_140_21 + 2 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			if 0.633333333333333 < arg_137_1.time_ and arg_137_1.time_ <= 0.633333333333333 + arg_140_0 then
				arg_137_1:AudioAction("stop", "effect", "se_story_141", "se_story_140_amb_drain", "")
			end

			if 1.8 < arg_137_1.time_ and arg_137_1.time_ <= 1.8 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_24 = 4
			local var_140_25 = 1.525

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_24 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_26 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_26:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_27 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(321321034).content)

				arg_137_1.text_.text = var_140_27

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_29 = 61 <= 0 and var_140_25 or var_140_25 * (utf8.len(var_140_27) / 61)

				if (61 <= 0 and var_140_25 or var_140_25 * (utf8.len(var_140_27) / 61)) > 0 and var_140_25 < var_140_29 then
					arg_137_1.talkMaxDuration = var_140_29
					var_140_24 = var_140_24 + 0.3

					if var_140_29 + var_140_24 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_29 + var_140_24
					end
				end

				arg_137_1.text_.text = var_140_27
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_30 = var_140_24 + 0.3
			local var_140_31 = math.max(var_140_25, arg_137_1.talkMaxDuration)

			if var_140_24 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_31 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_31

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_31 and arg_137_1.time_ < var_140_30 + var_140_31 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "L11f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play321321035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321321035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321321036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.55

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(321321035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 62 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 62)

				if (62 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 62)) > 0 and var_146_0 < var_146_3 then
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
	Play321321036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321321036
		arg_147_1.duration_ = 4.23

		local var_147_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_147_0:Play321321037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_150_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_147_1.stage_.transform)

				var_150_0.name = "404001ui_story"
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["404001ui_story"] = var_150_0

				local var_150_1 = var_150_0:GetComponentInChildren(typeof(CharacterEffect))

				var_150_1.enabled = true

				local var_150_2 = GameObjectTools.GetOrAddComponent(var_150_0, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(false)
				end

				arg_147_1:ShowWeapon(var_150_1.transform, false)

				arg_147_1.var_["404001ui_story" .. "Animator"] = var_150_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_147_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_147_1.var_["404001ui_story" .. "LipSync"] = var_150_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_150_3 = arg_147_1.actors_["404001ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos404001ui_story = var_150_3.localPosition
			end

			local var_150_4 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_3.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_147_1.time_ - 0) / var_150_4)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			local var_150_5 = arg_147_1.actors_["404001ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_6 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_5) then
					arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect404001ui_story then
				arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_150_8 = 0
			local var_150_9 = 0.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(321321036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 11 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 11)

				if (11 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 11)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321036", "story_v_out_321321.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321036", "story_v_out_321321.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_321321", "321321036", "story_v_out_321321.awb")

						arg_147_1:RecordAudio("321321036", var_150_15)
						arg_147_1:RecordAudio("321321036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321321", "321321036", "story_v_out_321321.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321321", "321321036", "story_v_out_321321.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play321321037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321321037
		arg_151_1.duration_ = 7.47

		local var_151_0 = {
			zh = 6.533,
			ja = 7.466
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321321038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1211ui_story = arg_151_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).z)
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles = arg_151_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_151_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1211ui_story"].transform.position).z)
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1211ui_story"].transform.localEulerAngles = arg_151_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["404001ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos404001ui_story = var_154_1.localPosition
			end

			local var_154_2 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 then
				var_154_1.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_151_1.time_ - 0) / var_154_2)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 then
				var_154_1.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			local var_154_3 = arg_151_1.actors_["1211ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect1211ui_story == nil then
				arg_151_1.var_.characterEffect1211ui_story = var_154_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_4 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 and not isNil(var_154_3) then
				if arg_151_1.var_.characterEffect1211ui_story and not isNil(var_154_3) then
					arg_151_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect1211ui_story then
				arg_151_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_154_6 = arg_151_1.actors_["404001ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect404001ui_story == nil then
				arg_151_1.var_.characterEffect404001ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_7 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 and not isNil(var_154_6) then
				if arg_151_1.var_.characterEffect404001ui_story and not isNil(var_154_6) then
					arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_151_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_7)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect404001ui_story then
				arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_151_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_154_8 = 0
			local var_154_9 = 0.675

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(321321037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 27 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 27)

				if (27 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 27)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321037", "story_v_out_321321.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321037", "story_v_out_321321.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_321321", "321321037", "story_v_out_321321.awb")

						arg_151_1:RecordAudio("321321037", var_154_15)
						arg_151_1:RecordAudio("321321037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321321", "321321037", "story_v_out_321321.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321321", "321321037", "story_v_out_321321.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play321321038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321321038
		arg_155_1.duration_ = 11.5

		local var_155_0 = {
			zh = 5.5,
			ja = 11.5
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
				arg_155_0:Play321321039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061ui_story = arg_155_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).z)
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles = arg_155_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.15)
				arg_155_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1061ui_story"].transform.position).z)
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1061ui_story"].transform.localEulerAngles = arg_155_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1211ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1211ui_story = var_158_1.localPosition
			end

			local var_158_2 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 then
				var_158_1.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_155_1.time_ - 0) / var_158_2)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 then
				var_158_1.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			local var_158_3 = arg_155_1.actors_["404001ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos404001ui_story = var_158_3.localPosition
			end

			local var_158_4 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				var_158_3.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_4)
				var_158_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_3.position).x, (manager.ui.mainCamera.transform.position - var_158_3.position).y, (manager.ui.mainCamera.transform.position - var_158_3.position).z)
				var_158_3.localEulerAngles.z = 0
				var_158_3.localEulerAngles.x = 0
				var_158_3.localEulerAngles = var_158_3.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				var_158_3.localPosition = Vector3.New(0, 100, 0)
				var_158_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_3.position).x, (manager.ui.mainCamera.transform.position - var_158_3.position).y, (manager.ui.mainCamera.transform.position - var_158_3.position).z)
				var_158_3.localEulerAngles.z = 0
				var_158_3.localEulerAngles.x = 0
				var_158_3.localEulerAngles = var_158_3.localEulerAngles
			end

			local var_158_5 = arg_155_1.actors_["1061ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect1061ui_story == nil then
				arg_155_1.var_.characterEffect1061ui_story = var_158_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_6 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.characterEffect1061ui_story and not isNil(var_158_5) then
					arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect1061ui_story then
				arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_158_8 = arg_155_1.actors_["1211ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.characterEffect1211ui_story == nil then
				arg_155_1.var_.characterEffect1211ui_story = var_158_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_9 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 and not isNil(var_158_8) then
				if arg_155_1.var_.characterEffect1211ui_story and not isNil(var_158_8) then
					arg_155_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_9)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.characterEffect1211ui_story then
				arg_155_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_10 = 0
			local var_158_11 = 0.675

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_12 = arg_155_1:GetWordFromCfg(321321038)
				local var_158_13 = arg_155_1:FormatText(var_158_12.content)

				arg_155_1.text_.text = var_158_13

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 27 <= 0 and var_158_11 or var_158_11 * (utf8.len(var_158_13) / 27)

				if (27 <= 0 and var_158_11 or var_158_11 * (utf8.len(var_158_13) / 27)) > 0 and var_158_11 < var_158_15 then
					arg_155_1.talkMaxDuration = var_158_15

					if var_158_15 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_15 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_13
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321038", "story_v_out_321321.awb") ~= 0 then
					local var_158_16 = manager.audio:GetVoiceLength("story_v_out_321321", "321321038", "story_v_out_321321.awb") / 1000

					if var_158_16 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_10
					end

					if var_158_12.prefab_name ~= "" and arg_155_1.actors_[var_158_12.prefab_name] ~= nil then
						local var_158_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_12.prefab_name].transform, "story_v_out_321321", "321321038", "story_v_out_321321.awb")

						arg_155_1:RecordAudio("321321038", var_158_17)
						arg_155_1:RecordAudio("321321038", var_158_17)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321321", "321321038", "story_v_out_321321.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321321", "321321038", "story_v_out_321321.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_18 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_18 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_18

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_18 and arg_155_1.time_ < var_158_10 + var_158_18 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play321321039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321321039
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321321040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10104ui_story = arg_159_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).z)
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles = arg_159_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_159_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10104ui_story"].transform.position).z)
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10104ui_story"].transform.localEulerAngles = arg_159_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1061ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1061ui_story = var_162_1.localPosition
			end

			local var_162_2 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 then
				var_162_1.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_159_1.time_ - 0) / var_162_2)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 then
				var_162_1.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			local var_162_3 = arg_159_1.actors_["1211ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1211ui_story = var_162_3.localPosition
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_4)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, 100, 0)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			local var_162_5 = arg_159_1.actors_["10104ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect10104ui_story == nil then
				arg_159_1.var_.characterEffect10104ui_story = var_162_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.characterEffect10104ui_story and not isNil(var_162_5) then
					arg_159_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect10104ui_story then
				arg_159_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_162_8 = arg_159_1.actors_["1061ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.characterEffect1061ui_story == nil then
				arg_159_1.var_.characterEffect1061ui_story = var_162_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_9 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_9 and not isNil(var_162_8) then
				if arg_159_1.var_.characterEffect1061ui_story and not isNil(var_162_8) then
					arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_9)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_9 and arg_159_1.time_ < 0 + var_162_9 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.characterEffect1061ui_story then
				arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_10 = 0
			local var_162_11 = 0.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_12 = arg_159_1:GetWordFromCfg(321321039)
				local var_162_13 = arg_159_1:FormatText(var_162_12.content)

				arg_159_1.text_.text = var_162_13

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 6 <= 0 and var_162_11 or var_162_11 * (utf8.len(var_162_13) / 6)

				if (6 <= 0 and var_162_11 or var_162_11 * (utf8.len(var_162_13) / 6)) > 0 and var_162_11 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_13
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321039", "story_v_out_321321.awb") ~= 0 then
					local var_162_16 = manager.audio:GetVoiceLength("story_v_out_321321", "321321039", "story_v_out_321321.awb") / 1000

					if var_162_16 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_16 + var_162_10
					end

					if var_162_12.prefab_name ~= "" and arg_159_1.actors_[var_162_12.prefab_name] ~= nil then
						local var_162_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_12.prefab_name].transform, "story_v_out_321321", "321321039", "story_v_out_321321.awb")

						arg_159_1:RecordAudio("321321039", var_162_17)
						arg_159_1:RecordAudio("321321039", var_162_17)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321321", "321321039", "story_v_out_321321.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321321", "321321039", "story_v_out_321321.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_18 and arg_159_1.time_ < var_162_10 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_159_1:InitPlayNodeList()
	end,
	Play321321040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321321040
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 2.6,
			ja = 4.5
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
				arg_163_0:Play321321041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1061ui_story"]) and arg_163_1.var_.characterEffect1061ui_story == nil then
				arg_163_1.var_.characterEffect1061ui_story = arg_163_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1061ui_story"]) then
				if arg_163_1.var_.characterEffect1061ui_story and not isNil(arg_163_1.actors_["1061ui_story"]) then
					arg_163_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1061ui_story"]) and arg_163_1.var_.characterEffect1061ui_story then
				arg_163_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_166_2 = arg_163_1.actors_["10104ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect10104ui_story == nil then
				arg_163_1.var_.characterEffect10104ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect10104ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect10104ui_story then
				arg_163_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_166_4 = 0
			local var_166_5 = 0.35

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(321321040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 14 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 14)

				if (14 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 14)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321040", "story_v_out_321321.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321040", "story_v_out_321321.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_321321", "321321040", "story_v_out_321321.awb")

						arg_163_1:RecordAudio("321321040", var_166_11)
						arg_163_1:RecordAudio("321321040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321321", "321321040", "story_v_out_321321.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321321", "321321040", "story_v_out_321321.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play321321041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321321041
		arg_167_1.duration_ = 7.57

		local var_167_0 = {
			zh = 6.433,
			ja = 7.566
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
				arg_167_0:Play321321042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos404001ui_story = arg_167_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).z)
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles = arg_167_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_167_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["404001ui_story"].transform.position).z)
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["404001ui_story"].transform.localEulerAngles = arg_167_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["404001ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect404001ui_story == nil then
				arg_167_1.var_.characterEffect404001ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect404001ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect404001ui_story then
				arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_170_4 = arg_167_1.actors_["1061ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect1061ui_story == nil then
				arg_167_1.var_.characterEffect1061ui_story = var_170_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_5 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 and not isNil(var_170_4) then
				if arg_167_1.var_.characterEffect1061ui_story and not isNil(var_170_4) then
					arg_167_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_5)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect1061ui_story then
				arg_167_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_6 = arg_167_1.actors_["1061ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1061ui_story = var_170_6.localPosition
			end

			local var_170_7 = 0.1

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_6.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_7)
				var_170_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_6.position).x, (manager.ui.mainCamera.transform.position - var_170_6.position).y, (manager.ui.mainCamera.transform.position - var_170_6.position).z)
				var_170_6.localEulerAngles.z = 0
				var_170_6.localEulerAngles.x = 0
				var_170_6.localEulerAngles = var_170_6.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_6.localPosition = Vector3.New(0, 100, 0)
				var_170_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_6.position).x, (manager.ui.mainCamera.transform.position - var_170_6.position).y, (manager.ui.mainCamera.transform.position - var_170_6.position).z)
				var_170_6.localEulerAngles.z = 0
				var_170_6.localEulerAngles.x = 0
				var_170_6.localEulerAngles = var_170_6.localEulerAngles
			end

			local var_170_8 = arg_167_1.actors_["10104ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10104ui_story = var_170_8.localPosition
			end

			local var_170_9 = 0.1

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 then
				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_9)
				var_170_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_8.position).x, (manager.ui.mainCamera.transform.position - var_170_8.position).y, (manager.ui.mainCamera.transform.position - var_170_8.position).z)
				var_170_8.localEulerAngles.z = 0
				var_170_8.localEulerAngles.x = 0
				var_170_8.localEulerAngles = var_170_8.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, 100, 0)
				var_170_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_8.position).x, (manager.ui.mainCamera.transform.position - var_170_8.position).y, (manager.ui.mainCamera.transform.position - var_170_8.position).z)
				var_170_8.localEulerAngles.z = 0
				var_170_8.localEulerAngles.x = 0
				var_170_8.localEulerAngles = var_170_8.localEulerAngles
			end

			local var_170_10 = 0
			local var_170_11 = 0.875

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_12 = arg_167_1:GetWordFromCfg(321321041)
				local var_170_13 = arg_167_1:FormatText(var_170_12.content)

				arg_167_1.text_.text = var_170_13

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_15 = 35 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 35)

				if (35 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 35)) > 0 and var_170_11 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_10
					end
				end

				arg_167_1.text_.text = var_170_13
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321041", "story_v_out_321321.awb") ~= 0 then
					local var_170_16 = manager.audio:GetVoiceLength("story_v_out_321321", "321321041", "story_v_out_321321.awb") / 1000

					if var_170_16 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_10
					end

					if var_170_12.prefab_name ~= "" and arg_167_1.actors_[var_170_12.prefab_name] ~= nil then
						local var_170_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_12.prefab_name].transform, "story_v_out_321321", "321321041", "story_v_out_321321.awb")

						arg_167_1:RecordAudio("321321041", var_170_17)
						arg_167_1:RecordAudio("321321041", var_170_17)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321321", "321321041", "story_v_out_321321.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321321", "321321041", "story_v_out_321321.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = math.max(var_170_11, arg_167_1.talkMaxDuration)

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_18 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_10) / var_170_18

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_10 + var_170_18 and arg_167_1.time_ < var_170_10 + var_170_18 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play321321042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321321042
		arg_171_1.duration_ = 3.17

		local var_171_0 = {
			zh = 1.533,
			ja = 3.166
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321321043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.175

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(321321042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 7 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 7)

				if (7 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 7)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321042", "story_v_out_321321.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_321321", "321321042", "story_v_out_321321.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_321321", "321321042", "story_v_out_321321.awb")

						arg_171_1:RecordAudio("321321042", var_174_6)
						arg_171_1:RecordAudio("321321042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_321321", "321321042", "story_v_out_321321.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_321321", "321321042", "story_v_out_321321.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play321321043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321321043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321321044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos404001ui_story = arg_175_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["404001ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect404001ui_story == nil then
				arg_175_1.var_.characterEffect404001ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect404001ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_175_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect404001ui_story then
				arg_175_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_175_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.8 < arg_175_1.time_ and arg_175_1.time_ <= 0.8 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_178_4 = 0
			local var_178_5 = 1.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(321321043).content)

				arg_175_1.text_.text = var_178_6

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_8 = 58 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_6) / 58)

				if (58 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_6) / 58)) > 0 and var_178_5 < var_178_8 then
					arg_175_1.talkMaxDuration = var_178_8

					if var_178_8 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_6
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_9 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_9 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_9

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_9 and arg_175_1.time_ < var_178_4 + var_178_9 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play321321044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321321044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321321045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0.05 < arg_179_1.time_ and arg_179_1.time_ <= 0.05 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_jump", "")
			end

			local var_182_1 = 0
			local var_182_2 = 1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(321321044).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 40 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 40)

				if (40 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 40)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321321045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321321045
		arg_183_1.duration_ = 6.27

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321321046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_9000

			if 0.5333333 < arg_183_1.time_ and arg_183_1.time_ <= 0.5333333 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_186_0 = 0.9666667

			if 0.5333333 <= arg_183_1.time_ and arg_183_1.time_ < 0.5333333 + var_186_0 then
				local var_186_1, var_186_2 = math.modf((arg_183_1.time_ - 0.5333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_186_2 * 0.13, var_186_2 * 0.13, var_186_2 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= 0.5333333 + var_186_0 and arg_183_1.time_ < 0.5333333 + var_186_0 + arg_186_0 then
				manager.ui.mainCamera.transform.localPosition = arg_183_1.var_.shakeOldPos
			end

			local var_186_3 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_3 + 1.5 and arg_183_1.time_ < var_186_3 + 1.5 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_4 = arg_183_1.var_.effectbaiqnzhanqi1

				if not arg_183_1.var_.effectbaiqnzhanqi1 then
					var_186_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_186_4.name = "baiqnzhanqi1"
					arg_183_1.var_.effectbaiqnzhanqi1 = var_186_4
				else
					var_186_4.transform:SetParent(var_186_9000)
				end

				var_186_4.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_186_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				if arg_183_1.var_.effectbaiqnzhanqi1 then
					Object.Destroy(arg_183_1.var_.effectbaiqnzhanqi1)

					arg_183_1.var_.effectbaiqnzhanqi1 = nil
				end
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_8 = 1.26666666666667
			local var_186_9 = 1.5

			if 1.26666666666667 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_10 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_10:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_11 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(321321045).content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 60 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 60)

				if (60 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 60)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13
					var_186_8 = var_186_8 + 0.3

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = var_186_8 + 0.3
			local var_186_15 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_14 + var_186_15 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_14) / var_186_15

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_14 + var_186_15 and arg_183_1.time_ < var_186_14 + var_186_15 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play321321046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321321046
		arg_189_1.duration_ = 4.17

		local var_189_0 = {
			zh = 2.766,
			ja = 4.166
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
				arg_189_0:Play321321047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1211ui_story = arg_189_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).z)
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles = arg_189_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_189_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1211ui_story"].transform.position).z)
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1211ui_story"].transform.localEulerAngles = arg_189_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1211ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1211ui_story == nil then
				arg_189_1.var_.characterEffect1211ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1211ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1211ui_story then
				arg_189_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.325

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(321321046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 13 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 13)

				if (13 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 13)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321046", "story_v_out_321321.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321046", "story_v_out_321321.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_321321", "321321046", "story_v_out_321321.awb")

						arg_189_1:RecordAudio("321321046", var_192_11)
						arg_189_1:RecordAudio("321321046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321321", "321321046", "story_v_out_321321.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321321", "321321046", "story_v_out_321321.awb")
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
				actorName = "1211ui_story",
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
	Play321321047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321321047
		arg_193_1.duration_ = 5.92

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321321048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_9000

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = arg_193_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).z)
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles = arg_193_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1211ui_story"].transform.position).z)
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1211ui_story"].transform.localEulerAngles = arg_193_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1211ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.034000001847744

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_2)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1211ui_story then
				arg_193_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_196_3 = manager.ui.mainCamera.transform

			if 0.3 < arg_193_1.time_ and arg_193_1.time_ <= 0.3 + arg_196_0 then
				arg_193_1.var_.shakeOldPos = var_196_3.localPosition
			end

			local var_196_4 = 1

			if 0.3 <= arg_193_1.time_ and arg_193_1.time_ < 0.3 + var_196_4 then
				local var_196_5, var_196_6 = math.modf((arg_193_1.time_ - 0.3) / 0.066)

				var_196_3.localPosition = Vector3.New(var_196_6 * 0.13, var_196_6 * 0.13, var_196_6 * 0.13) + arg_193_1.var_.shakeOldPos
			end

			if arg_193_1.time_ >= 0.3 + var_196_4 and arg_193_1.time_ < 0.3 + var_196_4 + arg_196_0 then
				var_196_3.localPosition = arg_193_1.var_.shakeOldPos
			end

			local var_196_7 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_7 + 0.924999997019768 and arg_193_1.time_ < var_196_7 + 0.924999997019768 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if 0.3 < arg_193_1.time_ and arg_193_1.time_ <= 0.3 + arg_196_0 then
				local var_196_8 = arg_193_1.var_.effectzhanduanshihai1

				if not arg_193_1.var_.effectzhanduanshihai1 then
					var_196_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), manager.ui.mainCamera.transform)
					var_196_8.name = "zhanduanshihai1"
					arg_193_1.var_.effectzhanduanshihai1 = var_196_8
				else
					var_196_8.transform:SetParent(var_196_9000)
				end

				var_196_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.3 < arg_193_1.time_ and arg_193_1.time_ <= 2.3 + arg_196_0 then
				if arg_193_1.var_.effectzhanduanshihai1 then
					Object.Destroy(arg_193_1.var_.effectzhanduanshihai1)

					arg_193_1.var_.effectzhanduanshihai1 = nil
				end
			end

			if 0.3 < arg_193_1.time_ and arg_193_1.time_ <= 0.3 + arg_196_0 then
				arg_193_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_monsterdeath", "")
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_12 = 0.924999997019768
			local var_196_13 = 1.125

			if 0.924999997019768 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_14 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_14:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(321321047).content)

				arg_193_1.text_.text = var_196_15

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 45 <= 0 and var_196_13 or var_196_13 * (utf8.len(var_196_15) / 45)

				if (45 <= 0 and var_196_13 or var_196_13 * (utf8.len(var_196_15) / 45)) > 0 and var_196_13 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17
					var_196_12 = var_196_12 + 0.3

					if var_196_17 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_15
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_18 = var_196_12 + 0.3
			local var_196_19 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_18 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_18) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_18 + var_196_19 and arg_193_1.time_ < var_196_18 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play321321048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321321048
		arg_199_1.duration_ = 8.73

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play321321049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if arg_199_1.bgs_.STblack == nil then
				local var_202_0 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_202_0.name = "STblack"
				var_202_0.transform.parent = arg_199_1.stage_.transform
				var_202_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_.STblack = var_202_0
			end

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				local var_202_1 = arg_199_1.bgs_.STblack

				arg_199_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_2 = var_202_1:GetComponent("SpriteRenderer")

				if var_202_2 and var_202_2.sprite then
					local var_202_3 = 2 * (var_202_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_1.transform.localScale = Vector3.New(var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "STblack" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_4 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_5 = 2

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_5 then
				local var_202_6 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_6.a = Mathf.Lerp(0, 1, (arg_199_1.time_ - var_202_4) / var_202_5)
				arg_199_1.mask_.color = var_202_6
			end

			if arg_199_1.time_ >= var_202_4 + var_202_5 and arg_199_1.time_ < var_202_4 + var_202_5 + arg_202_0 then
				local var_202_7 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_7.a = 1
				arg_199_1.mask_.color = var_202_7
			end

			local var_202_8 = 2

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_9 = 2

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 then
				local var_202_10 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_10.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_8) / var_202_9)
				arg_199_1.mask_.color = var_202_10
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 then
				local var_202_11 = Color.New(0.3301887, 0.08877714, 0.08877714)

				arg_199_1.mask_.enabled = false
				var_202_11.a = 0
				arg_199_1.mask_.color = var_202_11
			end

			if 1.83333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 1.83333333333333 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_141", "se_story_141_baqin_flag", "")
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_13 = 3.73333333333333
			local var_202_14 = 1.4

			if 3.73333333333333 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_15 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_15:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_16 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(321321048).content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_18 = 56 <= 0 and var_202_14 or var_202_14 * (utf8.len(var_202_16) / 56)

				if (56 <= 0 and var_202_14 or var_202_14 * (utf8.len(var_202_16) / 56)) > 0 and var_202_14 < var_202_18 then
					arg_199_1.talkMaxDuration = var_202_18
					var_202_13 = var_202_13 + 0.3

					if var_202_18 + var_202_13 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_13
					end
				end

				arg_199_1.text_.text = var_202_16
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_19 = var_202_13 + 0.3
			local var_202_20 = math.max(var_202_14, arg_199_1.talkMaxDuration)

			if var_202_13 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_19 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_19) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_19 + var_202_20 and arg_199_1.time_ < var_202_19 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play321321049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321321049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(321321049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 40 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 40)

				if (40 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 40)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L08f",
		"TextureConfig/Background/L11f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_321321.awb"
	}
}
