return {
	Play1108503001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108503001
		arg_1_1.duration_ = 11.27

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108503002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST20 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST20")
				var_4_0.name = "ST20"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST20 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST20

				arg_1_1.bgs_.ST20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST20" then
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

			local var_4_9 = "1037ui_story"

			if arg_1_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1037ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1037ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.09, -5.81)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1037ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1037ui_story == nil then
				arg_1_1.var_.characterEffect1037ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1037ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1037ui_story then
				arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
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
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.8

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(1108503001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 32 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 32)

				if (32 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 32)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")

						arg_1_1:RecordAudio("1108503001", var_4_33)
						arg_1_1:RecordAudio("1108503001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")
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
				actorName = "1037ui_story",
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
	Play1108503002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108503002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108503003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1037ui_story = arg_9_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).z)
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles = arg_9_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1037ui_story"].transform.position).z)
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1037ui_story"].transform.localEulerAngles = arg_9_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1037ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1037ui_story == nil then
				arg_9_1.var_.characterEffect1037ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1037ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1037ui_story then
				arg_9_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0.433333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.433333333333333 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			local var_12_4 = 0
			local var_12_5 = 0.825

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

				local var_12_6 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1108503002).content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 33 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 33)

				if (33 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 33)) > 0 and var_12_5 < var_12_8 then
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
				actorName = "1037ui_story",
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
	Play1108503003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108503003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1108503004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1108503003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)) > 0 and var_16_0 < var_16_3 then
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
	Play1108503004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108503004
		arg_17_1.duration_ = 5.1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108503005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1037ui_story = arg_17_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).z)
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles = arg_17_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_17_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1037ui_story"].transform.position).z)
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1037ui_story"].transform.localEulerAngles = arg_17_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1037ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1037ui_story == nil then
				arg_17_1.var_.characterEffect1037ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1037ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1037ui_story then
				arg_17_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(1108503004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 25 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 25)

				if (25 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 25)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")

						arg_17_1:RecordAudio("1108503004", var_20_11)
						arg_17_1:RecordAudio("1108503004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")
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
				actorName = "1037ui_story",
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
	Play1108503005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108503005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1108503006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1037ui_story"]) and arg_21_1.var_.characterEffect1037ui_story == nil then
				arg_21_1.var_.characterEffect1037ui_story = arg_21_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1037ui_story"]) then
				if arg_21_1.var_.characterEffect1037ui_story and not isNil(arg_21_1.actors_["1037ui_story"]) then
					arg_21_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1037ui_story"]) and arg_21_1.var_.characterEffect1037ui_story then
				arg_21_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1108503005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 22 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 22)

				if (22 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 22)) > 0 and var_24_2 < var_24_5 then
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
	Play1108503006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108503006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1108503007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1108503006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)

				if (11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1108503007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108503007
		arg_29_1.duration_ = 5.93

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1108503008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1037ui_story = arg_29_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).z)
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles = arg_29_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_29_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1037ui_story"].transform.position).z)
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1037ui_story"].transform.localEulerAngles = arg_29_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1037ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1037ui_story == nil then
				arg_29_1.var_.characterEffect1037ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1037ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1037ui_story then
				arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(1108503007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 25 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 25)

				if (25 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 25)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")

						arg_29_1:RecordAudio("1108503007", var_32_11)
						arg_29_1:RecordAudio("1108503007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")
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

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play1108503008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108503008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1108503009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) and arg_33_1.var_.characterEffect1037ui_story == nil then
				arg_33_1.var_.characterEffect1037ui_story = arg_33_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) then
				if arg_33_1.var_.characterEffect1037ui_story and not isNil(arg_33_1.actors_["1037ui_story"]) then
					arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1037ui_story"]) and arg_33_1.var_.characterEffect1037ui_story then
				arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1108503008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 31 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 31)

				if (31 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 31)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1108503009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108503009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108503010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1037ui_story = arg_37_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).z)
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles = arg_37_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1037ui_story"].transform.position).z)
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1037ui_story"].transform.localEulerAngles = arg_37_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_40_1 = 0
			local var_40_2 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1108503009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 25 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 25)

				if (25 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 25)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play1108503010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108503010
		arg_41_1.duration_ = 9.17

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1108503011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1037ui_story = arg_41_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).z)
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles = arg_41_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_41_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1037ui_story"].transform.position).z)
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1037ui_story"].transform.localEulerAngles = arg_41_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1037ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1037ui_story == nil then
				arg_41_1.var_.characterEffect1037ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1037ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1037ui_story then
				arg_41_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_44_4 = 0
			local var_44_5 = 0.875

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1108503010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 35 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 35)

				if (35 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 35)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")

						arg_41_1:RecordAudio("1108503010", var_44_11)
						arg_41_1:RecordAudio("1108503010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play1108503011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108503011
		arg_45_1.duration_ = 3.57

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108503012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_48_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_45_1.stage_.transform)

				var_48_0.name = "1085ui_story"
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1085ui_story"] = var_48_0

				local var_48_1 = var_48_0:GetComponentInChildren(typeof(CharacterEffect))

				var_48_1.enabled = true

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_1.transform, false)

				arg_45_1.var_["1085ui_story" .. "Animator"] = var_48_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_45_1.var_["1085ui_story" .. "LipSync"] = var_48_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_3 = arg_45_1.actors_["1085ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1085ui_story = var_48_3.localPosition
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_3.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_45_1.time_ - 0) / var_48_4)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_3.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			local var_48_5 = arg_45_1.actors_["1085ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1085ui_story == nil then
				arg_45_1.var_.characterEffect1085ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.characterEffect1085ui_story and not isNil(var_48_5) then
					arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1085ui_story then
				arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_48_8 = arg_45_1.actors_["1037ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.characterEffect1037ui_story == nil then
				arg_45_1.var_.characterEffect1037ui_story = var_48_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_9 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 and not isNil(var_48_8) then
				if arg_45_1.var_.characterEffect1037ui_story and not isNil(var_48_8) then
					arg_45_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_9)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.characterEffect1037ui_story then
				arg_45_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_10 = 0
			local var_48_11 = 0.25

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:GetWordFromCfg(1108503011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 10 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 10)

				if (10 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 10)) > 0 and var_48_11 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb") / 1000

					if var_48_16 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_10
					end

					if var_48_12.prefab_name ~= "" and arg_45_1.actors_[var_48_12.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_12.prefab_name].transform, "story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")

						arg_45_1:RecordAudio("1108503011", var_48_17)
						arg_45_1:RecordAudio("1108503011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_18 and arg_45_1.time_ < var_48_10 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play1108503012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108503012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108503013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1085ui_story = arg_49_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).z)
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles = arg_49_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1085ui_story"].transform.position).z)
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1085ui_story"].transform.localEulerAngles = arg_49_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1037ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1037ui_story = var_52_1.localPosition
			end

			local var_52_2 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 then
				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(0, 100, 0)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			local var_52_3 = arg_49_1.actors_["1085ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_4)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1085ui_story then
				arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_52_5 = 0
			local var_52_6 = 0.625

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1108503012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 25 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 25)

				if (25 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 25)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_49_1:InitPlayNodeList()
	end,
	Play1108503013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108503013
		arg_53_1.duration_ = 2.93

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1108503014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1085ui_story = arg_53_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).z)
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles = arg_53_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_53_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1085ui_story"].transform.position).z)
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1085ui_story"].transform.localEulerAngles = arg_53_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1085ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1085ui_story == nil then
				arg_53_1.var_.characterEffect1085ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1085ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1085ui_story then
				arg_53_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1108503013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 4 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 4)

				if (4 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 4)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")

						arg_53_1:RecordAudio("1108503013", var_56_11)
						arg_53_1:RecordAudio("1108503013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")
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
				actorName = "1085ui_story",
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
	Play1108503014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108503014
		arg_57_1.duration_ = 8

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1108503015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1037ui_story = arg_57_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).z)
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles = arg_57_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_57_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1037ui_story"].transform.position).z)
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1037ui_story"].transform.localEulerAngles = arg_57_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1037ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1037ui_story == nil then
				arg_57_1.var_.characterEffect1037ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1037ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1037ui_story then
				arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1085ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1085ui_story == nil then
				arg_57_1.var_.characterEffect1085ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect1085ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1085ui_story then
				arg_57_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 1.025

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(1108503014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 41 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 41)

				if (41 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 41)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")

						arg_57_1:RecordAudio("1108503014", var_60_13)
						arg_57_1:RecordAudio("1108503014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play1108503015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108503015
		arg_61_1.duration_ = 7.93

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108503016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1037ui_story = arg_61_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).z)
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles = arg_61_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_61_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1037ui_story"].transform.position).z)
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1037ui_story"].transform.localEulerAngles = arg_61_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_1 = 0
			local var_64_2 = 1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(1108503015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 40)

				if (40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 40)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")

						arg_61_1:RecordAudio("1108503015", var_64_8)
						arg_61_1:RecordAudio("1108503015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")
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

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play1108503016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108503016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1108503017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = arg_65_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).z)
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles = arg_65_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_65_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1085ui_story"].transform.position).z)
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1085ui_story"].transform.localEulerAngles = arg_65_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1085ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1085ui_story == nil then
				arg_65_1.var_.characterEffect1085ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1085ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1085ui_story then
				arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1037ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1037ui_story == nil then
				arg_65_1.var_.characterEffect1037ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect1037ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1037ui_story then
				arg_65_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action423")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_68_6 = 0
			local var_68_7 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(1108503016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 5 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 5)

				if (5 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 5)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")

						arg_65_1:RecordAudio("1108503016", var_68_13)
						arg_65_1:RecordAudio("1108503016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play1108503017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108503017
		arg_69_1.duration_ = 5.33

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1108503018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1037ui_story = arg_69_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).z)
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles = arg_69_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_69_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1037ui_story"].transform.position).z)
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1037ui_story"].transform.localEulerAngles = arg_69_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1037ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1037ui_story == nil then
				arg_69_1.var_.characterEffect1037ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1037ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1037ui_story then
				arg_69_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["1085ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1085ui_story == nil then
				arg_69_1.var_.characterEffect1085ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect1085ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1085ui_story then
				arg_69_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_72_6 = 0
			local var_72_7 = 0.575

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(1108503017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 23 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 23)

				if (23 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 23)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")

						arg_69_1:RecordAudio("1108503017", var_72_13)
						arg_69_1:RecordAudio("1108503017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play1108503018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1108503018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1108503019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1085ui_story = arg_73_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).z)
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles = arg_73_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1085ui_story"].transform.position).z)
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1085ui_story"].transform.localEulerAngles = arg_73_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1037ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1037ui_story = var_76_1.localPosition
			end

			local var_76_2 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 then
				var_76_1.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_2)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				var_76_1.localPosition = Vector3.New(0, 100, 0)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			local var_76_3 = arg_73_1.actors_["1037ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1037ui_story == nil then
				arg_73_1.var_.characterEffect1037ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect1037ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_4)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1037ui_story then
				arg_73_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_76_5 = 0
			local var_76_6 = 1.025

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1108503018).content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 41 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_7) / 41)

				if (41 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_7) / 41)) > 0 and var_76_6 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_10 and arg_73_1.time_ < var_76_5 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_73_1:InitPlayNodeList()
	end,
	Play1108503019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1108503019
		arg_77_1.duration_ = 1

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"

			SetActive(arg_77_1.choicesGo_, true)

			for iter_78_0, iter_78_1 in ipairs(arg_77_1.choices_) do
				SetActive(iter_78_1.go, iter_78_0 <= 1)
			end

			arg_77_1.choices_[1].txt.text = arg_77_1:FormatText(StoryChoiceCfg[1635].name)
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1108503020(arg_77_1)
			end

			arg_77_1:RecordChoiceLog(1108503019, 1635)
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= 0 + 0.6 and arg_77_1.time_ < 0 + 0.6 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1108503020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1108503020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1108503021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0.2 < arg_81_1.time_ and arg_81_1.time_ <= 0.2 + arg_84_0 then
				arg_81_1:AudioAction("play", "effect", "se_story_140", "se_story_140_catch", "")
			end

			local var_84_1 = 0
			local var_84_2 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1108503020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)

				if (32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1108503021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1108503021
		arg_85_1.duration_ = 6.87

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1108503022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1085ui_story = arg_85_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).z)
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles = arg_85_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_85_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1085ui_story"].transform.position).z)
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1085ui_story"].transform.localEulerAngles = arg_85_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1085ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1085ui_story == nil then
				arg_85_1.var_.characterEffect1085ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1085ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1085ui_story then
				arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_88_4 = 0
			local var_88_5 = 0.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(1108503021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 19 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 19)

				if (19 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 19)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")

						arg_85_1:RecordAudio("1108503021", var_88_11)
						arg_85_1:RecordAudio("1108503021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")
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
				actorName = "1085ui_story",
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
	Play1108503022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1108503022
		arg_89_1.duration_ = 3.3

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1108503023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1037ui_story = arg_89_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).z)
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles = arg_89_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -5.81)
				arg_89_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1037ui_story"].transform.position).z)
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1037ui_story"].transform.localEulerAngles = arg_89_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1037ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1037ui_story == nil then
				arg_89_1.var_.characterEffect1037ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1037ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1037ui_story then
				arg_89_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["1085ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1085ui_story == nil then
				arg_89_1.var_.characterEffect1085ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1085ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1085ui_story then
				arg_89_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_92_6 = 0
			local var_92_7 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(1108503022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 18 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 18)

				if (18 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 18)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")

						arg_89_1:RecordAudio("1108503022", var_92_13)
						arg_89_1:RecordAudio("1108503022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play1108503023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1108503023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1108503024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1085ui_story = arg_93_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).z)
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles = arg_93_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_93_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1085ui_story"].transform.position).z)
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1085ui_story"].transform.localEulerAngles = arg_93_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1085ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1085ui_story == nil then
				arg_93_1.var_.characterEffect1085ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1085ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1085ui_story then
				arg_93_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["1037ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1037ui_story == nil then
				arg_93_1.var_.characterEffect1037ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_5 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 and not isNil(var_96_4) then
				if arg_93_1.var_.characterEffect1037ui_story and not isNil(var_96_4) then
					arg_93_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_5)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect1037ui_story then
				arg_93_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_6 = 0
			local var_96_7 = 0.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(1108503023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 3 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 3)

				if (3 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 3)) > 0 and var_96_7 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb") / 1000

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")

						arg_93_1:RecordAudio("1108503023", var_96_13)
						arg_93_1:RecordAudio("1108503023", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")
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
				actorName = "1085ui_story",
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
	Play1108503024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1108503024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1108503025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1085ui_story"]) and arg_97_1.var_.characterEffect1085ui_story == nil then
				arg_97_1.var_.characterEffect1085ui_story = arg_97_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1085ui_story"]) then
				if arg_97_1.var_.characterEffect1085ui_story and not isNil(arg_97_1.actors_["1085ui_story"]) then
					arg_97_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1085ui_story"]) and arg_97_1.var_.characterEffect1085ui_story then
				arg_97_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.775

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1108503024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 31 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 31)

				if (31 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 31)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1108503025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1108503025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1108503026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1108503025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 23)

				if (23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 23)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1108503026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1108503026
		arg_105_1.duration_ = 4.5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1108503027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1037ui_story = arg_105_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).z)
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles = arg_105_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -5.81)
				arg_105_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1037ui_story"].transform.position).z)
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1037ui_story"].transform.localEulerAngles = arg_105_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1037ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1037ui_story == nil then
				arg_105_1.var_.characterEffect1037ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1037ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1037ui_story then
				arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(1108503026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 16 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 16)

				if (16 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 16)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")

						arg_105_1:RecordAudio("1108503026", var_108_11)
						arg_105_1:RecordAudio("1108503026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play1108503027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108503027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108503028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1037ui_story = arg_109_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).z)
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles = arg_109_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1037ui_story"].transform.position).z)
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1037ui_story"].transform.localEulerAngles = arg_109_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1085ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1085ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_2)
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

			local var_112_3 = arg_109_1.actors_["1037ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1037ui_story == nil then
				arg_109_1.var_.characterEffect1037ui_story = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect1037ui_story and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_4)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1037ui_story then
				arg_109_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_112_5 = 0
			local var_112_6 = 0.5

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1108503027).content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 20 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_7) / 20)

				if (20 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_7) / 20)) > 0 and var_112_6 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_10 and arg_109_1.time_ < var_112_5 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
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
	Play1108503028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108503028
		arg_113_1.duration_ = 7.03

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1108503029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1037ui_story = arg_113_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).z)
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles = arg_113_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_113_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1037ui_story"].transform.position).z)
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1037ui_story"].transform.localEulerAngles = arg_113_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1037ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1037ui_story == nil then
				arg_113_1.var_.characterEffect1037ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1037ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1037ui_story then
				arg_113_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.875

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(1108503028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 35 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 35)

				if (35 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 35)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")

						arg_113_1:RecordAudio("1108503028", var_116_11)
						arg_113_1:RecordAudio("1108503028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")
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
				actorName = "1037ui_story",
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
	Play1108503029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108503029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1108503030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1037ui_story = arg_117_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).z)
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles = arg_117_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1037ui_story"].transform.position).z)
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1037ui_story"].transform.localEulerAngles = arg_117_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1037ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1037ui_story == nil then
				arg_117_1.var_.characterEffect1037ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1037ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1037ui_story then
				arg_117_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_120_3 = 0
			local var_120_4 = 0.525

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1108503029).content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 21 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 21)

				if (21 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 21)) > 0 and var_120_4 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_8 and arg_117_1.time_ < var_120_3 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play1108503030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108503030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108503031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.575

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1108503030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 23 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 23)

				if (23 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 23)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1108503031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1108503031
		arg_125_1.duration_ = 5.77

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1108503032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1037ui_story = arg_125_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).z)
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles = arg_125_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_125_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1037ui_story"].transform.position).z)
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1037ui_story"].transform.localEulerAngles = arg_125_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1037ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1037ui_story == nil then
				arg_125_1.var_.characterEffect1037ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1037ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1037ui_story then
				arg_125_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.8

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1108503031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 32 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 32)

				if (32 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 32)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")

						arg_125_1:RecordAudio("1108503031", var_128_11)
						arg_125_1:RecordAudio("1108503031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play1108503032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1108503032
		arg_129_1.duration_ = 2.9

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1108503033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1037ui_story = arg_129_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).z)
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles = arg_129_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_129_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1037ui_story"].transform.position).z)
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1037ui_story"].transform.localEulerAngles = arg_129_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action425")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_1 = 0
			local var_132_2 = 0.325

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(1108503032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 13 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 13)

				if (13 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 13)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")

						arg_129_1:RecordAudio("1108503032", var_132_8)
						arg_129_1:RecordAudio("1108503032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")
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
				actorName = "1037ui_story",
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
	Play1108503033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108503033
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1108503034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 1.96599999815226 < arg_133_1.time_ and arg_133_1.time_ <= 1.96599999815226 + arg_136_0 then
				arg_133_1.var_.moveOldPos1037ui_story = arg_133_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 1.96599999815226 <= arg_133_1.time_ and arg_133_1.time_ < 1.96599999815226 + var_136_0 then
				arg_133_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 1.96599999815226) / var_136_0)
				arg_133_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).z)
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles = arg_133_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 1.96599999815226 + var_136_0 and arg_133_1.time_ < 1.96599999815226 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1037ui_story"].transform.position).z)
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1037ui_story"].transform.localEulerAngles = arg_133_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1037ui_story"]

			if 1.96599999815226 < arg_133_1.time_ and arg_133_1.time_ <= 1.96599999815226 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1037ui_story == nil then
				arg_133_1.var_.characterEffect1037ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.034000001847744

			if 1.96599999815226 <= arg_133_1.time_ and arg_133_1.time_ < 1.96599999815226 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1037ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 1.96599999815226) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 1.96599999815226 + var_136_2 and arg_133_1.time_ < 1.96599999815226 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1037ui_story then
				arg_133_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_4 = 2

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_4 then
				local var_136_5 = Color.New(0, 0, 0)

				var_136_5.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_3) / var_136_4)
				arg_133_1.mask_.color = var_136_5
			end

			if arg_133_1.time_ >= var_136_3 + var_136_4 and arg_133_1.time_ < var_136_3 + var_136_4 + arg_136_0 then
				local var_136_6 = Color.New(0, 0, 0)

				var_136_6.a = 1
				arg_133_1.mask_.color = var_136_6
			end

			local var_136_7 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_8 = 2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 then
				local var_136_9 = Color.New(0, 0, 0)

				var_136_9.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_7) / var_136_8)
				arg_133_1.mask_.color = var_136_9
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 then
				local var_136_10 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_10.a = 0
				arg_133_1.mask_.color = var_136_10
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_11 = 4
			local var_136_12 = 0.875

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_13 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_13:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1108503033).content)

				arg_133_1.text_.text = var_136_14

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_16 = 35 <= 0 and var_136_12 or var_136_12 * (utf8.len(var_136_14) / 35)

				if (35 <= 0 and var_136_12 or var_136_12 * (utf8.len(var_136_14) / 35)) > 0 and var_136_12 < var_136_16 then
					arg_133_1.talkMaxDuration = var_136_16
					var_136_11 = var_136_11 + 0.3

					if var_136_16 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_11
					end
				end

				arg_133_1.text_.text = var_136_14
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_17 = var_136_11 + 0.3
			local var_136_18 = math.max(var_136_12, arg_133_1.talkMaxDuration)

			if var_136_11 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_17 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_17) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_17 + var_136_18 and arg_133_1.time_ < var_136_17 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1108503034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1108503034
		arg_139_1.duration_ = 4.87

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1108503035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1037ui_story = arg_139_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).z)
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles = arg_139_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_139_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1037ui_story"].transform.position).z)
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1037ui_story"].transform.localEulerAngles = arg_139_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1037ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1037ui_story == nil then
				arg_139_1.var_.characterEffect1037ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1037ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1037ui_story then
				arg_139_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_142_4 = 0
			local var_142_5 = 0.6

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(1108503034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 24 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 24)

				if (24 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 24)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")

						arg_139_1:RecordAudio("1108503034", var_142_11)
						arg_139_1:RecordAudio("1108503034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play1108503035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108503035
		arg_143_1.duration_ = 2.9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1108503036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1085ui_story = arg_143_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).z)
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles = arg_143_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_143_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1085ui_story"].transform.position).z)
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1085ui_story"].transform.localEulerAngles = arg_143_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1085ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1085ui_story == nil then
				arg_143_1.var_.characterEffect1085ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1085ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1085ui_story then
				arg_143_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_146_4 = arg_143_1.actors_["1037ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1037ui_story == nil then
				arg_143_1.var_.characterEffect1037ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_5 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 and not isNil(var_146_4) then
				if arg_143_1.var_.characterEffect1037ui_story and not isNil(var_146_4) then
					arg_143_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_5)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1037ui_story then
				arg_143_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.15

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(1108503035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 6 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 6)

				if (6 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 6)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")

						arg_143_1:RecordAudio("1108503035", var_146_13)
						arg_143_1:RecordAudio("1108503035", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play1108503036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1108503036
		arg_147_1.duration_ = 9

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1108503037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.B13 == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_150_0.name = "B13"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.B13 = var_150_0
			end

			if 1.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= 1.999999999999 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.B13

				arg_147_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "B13" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 3.999999999999

			if 3.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_4 + 0.3 and arg_147_1.time_ < var_150_4 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_5 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_6 = 2

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_5) / var_150_6)
				arg_147_1.mask_.color = var_150_7
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 then
				local var_150_8 = Color.New(0, 0, 0)

				var_150_8.a = 1
				arg_147_1.mask_.color = var_150_8
			end

			local var_150_9 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_10 = 2

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 then
				local var_150_11 = Color.New(0, 0, 0)

				var_150_11.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_9) / var_150_10)
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 then
				local var_150_12 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_12.a = 0
				arg_147_1.mask_.color = var_150_12
			end

			local var_150_13 = arg_147_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_147_1.time_ and arg_147_1.time_ <= 1.96599999815226 + arg_150_0 then
				arg_147_1.var_.moveOldPos1085ui_story = var_150_13.localPosition
			end

			local var_150_14 = 0.001

			if 1.96599999815226 <= arg_147_1.time_ and arg_147_1.time_ < 1.96599999815226 + var_150_14 then
				var_150_13.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 1.96599999815226) / var_150_14)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			if arg_147_1.time_ >= 1.96599999815226 + var_150_14 and arg_147_1.time_ < 1.96599999815226 + var_150_14 + arg_150_0 then
				var_150_13.localPosition = Vector3.New(0, 100, 0)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			local var_150_15 = arg_147_1.actors_["1037ui_story"].transform

			if 1.96599999815226 < arg_147_1.time_ and arg_147_1.time_ <= 1.96599999815226 + arg_150_0 then
				arg_147_1.var_.moveOldPos1037ui_story = var_150_15.localPosition
			end

			local var_150_16 = 0.001

			if 1.96599999815226 <= arg_147_1.time_ and arg_147_1.time_ < 1.96599999815226 + var_150_16 then
				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 1.96599999815226) / var_150_16)
				var_150_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_15.position).x, (manager.ui.mainCamera.transform.position - var_150_15.position).y, (manager.ui.mainCamera.transform.position - var_150_15.position).z)
				var_150_15.localEulerAngles.z = 0
				var_150_15.localEulerAngles.x = 0
				var_150_15.localEulerAngles = var_150_15.localEulerAngles
			end

			if arg_147_1.time_ >= 1.96599999815226 + var_150_16 and arg_147_1.time_ < 1.96599999815226 + var_150_16 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, 100, 0)
				var_150_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_15.position).x, (manager.ui.mainCamera.transform.position - var_150_15.position).y, (manager.ui.mainCamera.transform.position - var_150_15.position).z)
				var_150_15.localEulerAngles.z = 0
				var_150_15.localEulerAngles.x = 0
				var_150_15.localEulerAngles = var_150_15.localEulerAngles
			end

			local var_150_17 = arg_147_1.actors_["1085ui_story"]

			if 1.96599999815226 < arg_147_1.time_ and arg_147_1.time_ <= 1.96599999815226 + arg_150_0 and not isNil(var_150_17) and arg_147_1.var_.characterEffect1085ui_story == nil then
				arg_147_1.var_.characterEffect1085ui_story = var_150_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_18 = 0.034000001847744

			if 1.96599999815226 <= arg_147_1.time_ and arg_147_1.time_ < 1.96599999815226 + var_150_18 and not isNil(var_150_17) then
				if arg_147_1.var_.characterEffect1085ui_story and not isNil(var_150_17) then
					arg_147_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 1.96599999815226) / var_150_18)
				end
			end

			if arg_147_1.time_ >= 1.96599999815226 + var_150_18 and arg_147_1.time_ < 1.96599999815226 + var_150_18 + arg_150_0 and not isNil(var_150_17) and arg_147_1.var_.characterEffect1085ui_story then
				arg_147_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.266666666666667 < arg_147_1.time_ and arg_147_1.time_ <= 0.266666666666667 + arg_150_0 then
				arg_147_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_150_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_21 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_21

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_21
						arg_147_1.bgmTxt2_.text = var_150_21
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_147_1.time_ and arg_147_1.time_ <= 1.66666666666667 + arg_150_0 then
				arg_147_1:AudioAction("play", "music", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_150_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if "" ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_24 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_24

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_24
						arg_147_1.bgmTxt2_.text = var_150_24
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_147_1.time_ and arg_147_1.time_ <= 0.266666666666667 + arg_150_0 then
				arg_147_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.66666666666667 < arg_147_1.time_ and arg_147_1.time_ <= 1.66666666666667 + arg_150_0 then
				arg_147_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 4.5 < arg_147_1.time_ and arg_147_1.time_ <= 4.5 + arg_150_0 then
				arg_147_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_footstep", "")
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_28 = 3.999999999999
			local var_150_29 = 0.675

			if 3.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_30 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_30:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_147_1.dialogCg_.alpha = arg_153_0
				end))
				var_150_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_31 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1108503036).content)

				arg_147_1.text_.text = var_150_31

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_33 = 27 <= 0 and var_150_29 or var_150_29 * (utf8.len(var_150_31) / 27)

				if (27 <= 0 and var_150_29 or var_150_29 * (utf8.len(var_150_31) / 27)) > 0 and var_150_29 < var_150_33 then
					arg_147_1.talkMaxDuration = var_150_33
					var_150_28 = var_150_28 + 0.3

					if var_150_33 + var_150_28 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_33 + var_150_28
					end
				end

				arg_147_1.text_.text = var_150_31
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_34 = var_150_28 + 0.3
			local var_150_35 = math.max(var_150_29, arg_147_1.talkMaxDuration)

			if var_150_28 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_34 + var_150_35 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_34) / var_150_35

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_34 + var_150_35 and arg_147_1.time_ < var_150_34 + var_150_35 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1108503037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1108503037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1108503038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.125

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1108503037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 5 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 5)

				if (5 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 5)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1108503038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1108503038
		arg_159_1.duration_ = 7.1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1108503039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1085ui_story = arg_159_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).z)
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles = arg_159_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_159_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1085ui_story"].transform.position).z)
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1085ui_story"].transform.localEulerAngles = arg_159_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1085ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1085ui_story == nil then
				arg_159_1.var_.characterEffect1085ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1085ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1085ui_story then
				arg_159_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(1108503038)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 19 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 19)

				if (19 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 19)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")

						arg_159_1:RecordAudio("1108503038", var_162_11)
						arg_159_1:RecordAudio("1108503038", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play1108503039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1108503039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1108503040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1085ui_story"]) and arg_163_1.var_.characterEffect1085ui_story == nil then
				arg_163_1.var_.characterEffect1085ui_story = arg_163_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1085ui_story"]) then
				if arg_163_1.var_.characterEffect1085ui_story and not isNil(arg_163_1.actors_["1085ui_story"]) then
					arg_163_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1085ui_story"]) and arg_163_1.var_.characterEffect1085ui_story then
				arg_163_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.45

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

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1108503039).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 18 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 18)

				if (18 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 18)) > 0 and var_166_2 < var_166_5 then
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
	Play1108503040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1108503040
		arg_167_1.duration_ = 10.37

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1108503041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1085ui_story"]) and arg_167_1.var_.characterEffect1085ui_story == nil then
				arg_167_1.var_.characterEffect1085ui_story = arg_167_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1085ui_story"]) then
				if arg_167_1.var_.characterEffect1085ui_story and not isNil(arg_167_1.actors_["1085ui_story"]) then
					arg_167_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1085ui_story"]) and arg_167_1.var_.characterEffect1085ui_story then
				arg_167_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action434")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_170_2 = 0
			local var_170_3 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(1108503040)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 32 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 32)

				if (32 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 32)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")

						arg_167_1:RecordAudio("1108503040", var_170_9)
						arg_167_1:RecordAudio("1108503040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")
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
	Play1108503041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1108503041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1108503042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1085ui_story"]) and arg_171_1.var_.characterEffect1085ui_story == nil then
				arg_171_1.var_.characterEffect1085ui_story = arg_171_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1085ui_story"]) then
				if arg_171_1.var_.characterEffect1085ui_story and not isNil(arg_171_1.actors_["1085ui_story"]) then
					arg_171_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1085ui_story"]) and arg_171_1.var_.characterEffect1085ui_story then
				arg_171_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.75

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1108503041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 30 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 30)

				if (30 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 30)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1108503042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1108503042
		arg_175_1.duration_ = 3.87

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1108503043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1085ui_story = arg_175_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).z)
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles = arg_175_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_175_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1085ui_story"].transform.position).z)
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1085ui_story"].transform.localEulerAngles = arg_175_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1085ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1085ui_story == nil then
				arg_175_1.var_.characterEffect1085ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1085ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1085ui_story then
				arg_175_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_178_4 = 0
			local var_178_5 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(1108503042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)

				if (13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")

						arg_175_1:RecordAudio("1108503042", var_178_11)
						arg_175_1:RecordAudio("1108503042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play1108503043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1108503043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1108503044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1085ui_story = arg_179_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).z)
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles = arg_179_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1085ui_story"].transform.position).z)
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1085ui_story"].transform.localEulerAngles = arg_179_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1085ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1085ui_story == nil then
				arg_179_1.var_.characterEffect1085ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1085ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_2)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1085ui_story then
				arg_179_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_182_3 = 0
			local var_182_4 = 0.75

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1108503043).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 30 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 30)

				if (30 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 30)) > 0 and var_182_4 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_8 and arg_179_1.time_ < var_182_3 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play1108503044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1108503044
		arg_183_1.duration_ = 2.63

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1108503045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1085ui_story = arg_183_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).z)
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles = arg_183_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_183_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1085ui_story"].transform.position).z)
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1085ui_story"].transform.localEulerAngles = arg_183_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1085ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1085ui_story == nil then
				arg_183_1.var_.characterEffect1085ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1085ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1085ui_story then
				arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_186_4 = 0
			local var_186_5 = 0.125

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(1108503044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 5 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 5)

				if (5 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 5)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")

						arg_183_1:RecordAudio("1108503044", var_186_11)
						arg_183_1:RecordAudio("1108503044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play1108503045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1108503045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1108503046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) and arg_187_1.var_.characterEffect1085ui_story == nil then
				arg_187_1.var_.characterEffect1085ui_story = arg_187_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) then
				if arg_187_1.var_.characterEffect1085ui_story and not isNil(arg_187_1.actors_["1085ui_story"]) then
					arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1085ui_story"]) and arg_187_1.var_.characterEffect1085ui_story then
				arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1108503045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)

				if (23 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 23)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1108503046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1108503046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1108503047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.775

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1108503046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 31 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 31)

				if (31 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 31)) > 0 and var_194_0 < var_194_3 then
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
	Play1108503047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1108503047
		arg_195_1.duration_ = 6.4

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1108503048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1085ui_story = arg_195_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).z)
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles = arg_195_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_195_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1085ui_story"].transform.position).z)
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1085ui_story"].transform.localEulerAngles = arg_195_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1085ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1085ui_story == nil then
				arg_195_1.var_.characterEffect1085ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1085ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1085ui_story then
				arg_195_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_198_4 = 0
			local var_198_5 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(1108503047)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 13 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 13)

				if (13 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 13)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")

						arg_195_1:RecordAudio("1108503047", var_198_11)
						arg_195_1:RecordAudio("1108503047", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")
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

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play1108503048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1108503048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1108503049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1085ui_story"]) and arg_199_1.var_.characterEffect1085ui_story == nil then
				arg_199_1.var_.characterEffect1085ui_story = arg_199_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1085ui_story"]) then
				if arg_199_1.var_.characterEffect1085ui_story and not isNil(arg_199_1.actors_["1085ui_story"]) then
					arg_199_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1085ui_story"]) and arg_199_1.var_.characterEffect1085ui_story then
				arg_199_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.2

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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1108503048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 8 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 8)

				if (8 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 8)) > 0 and var_202_2 < var_202_5 then
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
	Play1108503049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1108503049
		arg_203_1.duration_ = 6.07

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1108503050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.ST07a == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07a")
				var_206_0.name = "ST07a"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.ST07a = var_206_0
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.ST07a

				arg_203_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST07a" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 4

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_4 + 0.3 and arg_203_1.time_ < var_206_4 + 0.3 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_5 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_6 = 2

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 then
				local var_206_7 = Color.New(0, 0, 0)

				var_206_7.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_5) / var_206_6)
				arg_203_1.mask_.color = var_206_7
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 then
				local var_206_8 = Color.New(0, 0, 0)

				var_206_8.a = 1
				arg_203_1.mask_.color = var_206_8
			end

			local var_206_9 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_10 = 2

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 then
				local var_206_11 = Color.New(0, 0, 0)

				var_206_11.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_9) / var_206_10)
				arg_203_1.mask_.color = var_206_11
			end

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 then
				local var_206_12 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_12.a = 0
				arg_203_1.mask_.color = var_206_12
			end

			local var_206_13 = "10066ui_story"

			if arg_203_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_206_14 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_203_1.stage_.transform)

				var_206_14.name = var_206_13
				var_206_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_[var_206_13] = var_206_14

				local var_206_15 = var_206_14:GetComponentInChildren(typeof(CharacterEffect))

				var_206_15.enabled = true

				local var_206_16 = GameObjectTools.GetOrAddComponent(var_206_14, typeof(DynamicBoneHelper))

				if var_206_16 then
					var_206_16:EnableDynamicBone(false)
				end

				arg_203_1:ShowWeapon(var_206_15.transform, false)

				arg_203_1.var_[var_206_13 .. "Animator"] = var_206_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_203_1.var_[var_206_13 .. "Animator"].applyRootMotion = true
				arg_203_1.var_[var_206_13 .. "LipSync"] = var_206_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_206_17 = arg_203_1.actors_["10066ui_story"].transform

			if 3.8 < arg_203_1.time_ and arg_203_1.time_ <= 3.8 + arg_206_0 then
				arg_203_1.var_.moveOldPos10066ui_story = var_206_17.localPosition
			end

			local var_206_18 = 0.001

			if 3.8 <= arg_203_1.time_ and arg_203_1.time_ < 3.8 + var_206_18 then
				var_206_17.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_203_1.time_ - 3.8) / var_206_18)
				var_206_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_17.position).x, (manager.ui.mainCamera.transform.position - var_206_17.position).y, (manager.ui.mainCamera.transform.position - var_206_17.position).z)
				var_206_17.localEulerAngles.z = 0
				var_206_17.localEulerAngles.x = 0
				var_206_17.localEulerAngles = var_206_17.localEulerAngles
			end

			if arg_203_1.time_ >= 3.8 + var_206_18 and arg_203_1.time_ < 3.8 + var_206_18 + arg_206_0 then
				var_206_17.localPosition = Vector3.New(0, -0.99, -5.83)
				var_206_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_17.position).x, (manager.ui.mainCamera.transform.position - var_206_17.position).y, (manager.ui.mainCamera.transform.position - var_206_17.position).z)
				var_206_17.localEulerAngles.z = 0
				var_206_17.localEulerAngles.x = 0
				var_206_17.localEulerAngles = var_206_17.localEulerAngles
			end

			local var_206_19 = arg_203_1.actors_["10066ui_story"]

			if 3.8 < arg_203_1.time_ and arg_203_1.time_ <= 3.8 + arg_206_0 and not isNil(var_206_19) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_20 = 0.200000002980232

			if 3.8 <= arg_203_1.time_ and arg_203_1.time_ < 3.8 + var_206_20 and not isNil(var_206_19) then
				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_19) then
					arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 3.8 + var_206_20 and arg_203_1.time_ < 3.8 + var_206_20 + arg_206_0 and not isNil(var_206_19) and arg_203_1.var_.characterEffect10066ui_story then
				arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 3.8 < arg_203_1.time_ and arg_203_1.time_ <= 3.8 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 3.8 < arg_203_1.time_ and arg_203_1.time_ <= 3.8 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_206_22 = arg_203_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_203_1.time_ and arg_203_1.time_ <= 1.96599999815226 + arg_206_0 then
				arg_203_1.var_.moveOldPos1085ui_story = var_206_22.localPosition
			end

			local var_206_23 = 0.001

			if 1.96599999815226 <= arg_203_1.time_ and arg_203_1.time_ < 1.96599999815226 + var_206_23 then
				var_206_22.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 1.96599999815226) / var_206_23)
				var_206_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_22.position).x, (manager.ui.mainCamera.transform.position - var_206_22.position).y, (manager.ui.mainCamera.transform.position - var_206_22.position).z)
				var_206_22.localEulerAngles.z = 0
				var_206_22.localEulerAngles.x = 0
				var_206_22.localEulerAngles = var_206_22.localEulerAngles
			end

			if arg_203_1.time_ >= 1.96599999815226 + var_206_23 and arg_203_1.time_ < 1.96599999815226 + var_206_23 + arg_206_0 then
				var_206_22.localPosition = Vector3.New(0, 100, 0)
				var_206_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_22.position).x, (manager.ui.mainCamera.transform.position - var_206_22.position).y, (manager.ui.mainCamera.transform.position - var_206_22.position).z)
				var_206_22.localEulerAngles.z = 0
				var_206_22.localEulerAngles.x = 0
				var_206_22.localEulerAngles = var_206_22.localEulerAngles
			end

			if 0.266666666666667 < arg_203_1.time_ and arg_203_1.time_ <= 0.266666666666667 + arg_206_0 then
				arg_203_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1.73333333333333 < arg_203_1.time_ and arg_203_1.time_ <= 1.73333333333333 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_26 = 4
			local var_206_27 = 0.25

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_26 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_28 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_28:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_29 = arg_203_1:GetWordFromCfg(1108503049)
				local var_206_30 = arg_203_1:FormatText(var_206_29.content)

				arg_203_1.text_.text = var_206_30

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_32 = 10 <= 0 and var_206_27 or var_206_27 * (utf8.len(var_206_30) / 10)

				if (10 <= 0 and var_206_27 or var_206_27 * (utf8.len(var_206_30) / 10)) > 0 and var_206_27 < var_206_32 then
					arg_203_1.talkMaxDuration = var_206_32
					var_206_26 = var_206_26 + 0.3

					if var_206_32 + var_206_26 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_32 + var_206_26
					end
				end

				arg_203_1.text_.text = var_206_30
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb") ~= 0 then
					local var_206_33 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb") / 1000

					if var_206_33 + var_206_26 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_33 + var_206_26
					end

					if var_206_29.prefab_name ~= "" and arg_203_1.actors_[var_206_29.prefab_name] ~= nil then
						local var_206_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_29.prefab_name].transform, "story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")

						arg_203_1:RecordAudio("1108503049", var_206_34)
						arg_203_1:RecordAudio("1108503049", var_206_34)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_35 = var_206_26 + 0.3
			local var_206_36 = math.max(var_206_27, arg_203_1.talkMaxDuration)

			if var_206_26 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_35 + var_206_36 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_35) / var_206_36

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_35 + var_206_36 and arg_203_1.time_ < var_206_35 + var_206_36 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_203_1:InitPlayNodeList()
	end,
	Play1108503050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108503050
		arg_209_1.duration_ = 2

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108503051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1085ui_story = arg_209_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).z)
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles = arg_209_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_209_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1085ui_story"].transform.position).z)
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1085ui_story"].transform.localEulerAngles = arg_209_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1085ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1085ui_story == nil then
				arg_209_1.var_.characterEffect1085ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1085ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1085ui_story then
				arg_209_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["10066ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect10066ui_story == nil then
				arg_209_1.var_.characterEffect10066ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect10066ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect10066ui_story then
				arg_209_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_6 = arg_209_1.actors_["10066ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10066ui_story = var_212_6.localPosition
			end

			local var_212_7 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				var_212_6.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_209_1.time_ - 0) / var_212_7)
				var_212_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_6.position).x, (manager.ui.mainCamera.transform.position - var_212_6.position).y, (manager.ui.mainCamera.transform.position - var_212_6.position).z)
				var_212_6.localEulerAngles.z = 0
				var_212_6.localEulerAngles.x = 0
				var_212_6.localEulerAngles = var_212_6.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				var_212_6.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_212_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_6.position).x, (manager.ui.mainCamera.transform.position - var_212_6.position).y, (manager.ui.mainCamera.transform.position - var_212_6.position).z)
				var_212_6.localEulerAngles.z = 0
				var_212_6.localEulerAngles.x = 0
				var_212_6.localEulerAngles = var_212_6.localEulerAngles
			end

			local var_212_8 = 0
			local var_212_9 = 0.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(1108503050)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 7 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 7)

				if (7 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 7)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")

						arg_209_1:RecordAudio("1108503050", var_212_15)
						arg_209_1:RecordAudio("1108503050", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1108503051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108503051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1108503052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10066ui_story = arg_213_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).z)
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles = arg_213_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10066ui_story"].transform.position).z)
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10066ui_story"].transform.localEulerAngles = arg_213_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1085ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1085ui_story = var_216_1.localPosition
			end

			local var_216_2 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 then
				var_216_1.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_2)
				var_216_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_1.position).x, (manager.ui.mainCamera.transform.position - var_216_1.position).y, (manager.ui.mainCamera.transform.position - var_216_1.position).z)
				var_216_1.localEulerAngles.z = 0
				var_216_1.localEulerAngles.x = 0
				var_216_1.localEulerAngles = var_216_1.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 then
				var_216_1.localPosition = Vector3.New(0, 100, 0)
				var_216_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_1.position).x, (manager.ui.mainCamera.transform.position - var_216_1.position).y, (manager.ui.mainCamera.transform.position - var_216_1.position).z)
				var_216_1.localEulerAngles.z = 0
				var_216_1.localEulerAngles.x = 0
				var_216_1.localEulerAngles = var_216_1.localEulerAngles
			end

			local var_216_3 = arg_213_1.actors_["1085ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect1085ui_story == nil then
				arg_213_1.var_.characterEffect1085ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect1085ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_4)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect1085ui_story then
				arg_213_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_216_5 = 0
			local var_216_6 = 1.275

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(1108503051).content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 51 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 51)

				if (51 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 51)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_10 and arg_213_1.time_ < var_216_5 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_213_1:InitPlayNodeList()
	end,
	Play1108503052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108503052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1108503053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1108503052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)

				if (10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1108503053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108503053
		arg_221_1.duration_ = 5.5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1108503054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = arg_221_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["10066ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_224_4 = 0
			local var_224_5 = 0.675

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(1108503053)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 27 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 27)

				if (27 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 27)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")

						arg_221_1:RecordAudio("1108503053", var_224_11)
						arg_221_1:RecordAudio("1108503053", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")
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
				actorName = "10066ui_story",
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
	Play1108503054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108503054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1108503055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = arg_225_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) then
				if arg_225_1.var_.characterEffect10066ui_story and not isNil(arg_225_1.actors_["10066ui_story"]) then
					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10066ui_story"]) and arg_225_1.var_.characterEffect10066ui_story then
				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.15

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1108503054).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 6 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 6)

				if (6 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 6)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108503055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108503055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1108503056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.6

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1108503055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 24 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 24)

				if (24 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 24)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1108503056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108503056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1108503057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_236_0 = 0
			local var_236_1 = 0.6

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1108503056).content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 24 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_2) / 24)

				if (24 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_2) / 24)) > 0 and var_236_1 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_5 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_5 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_5

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_5 and arg_233_1.time_ < var_236_0 + var_236_5 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1108503057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108503057
		arg_237_1.duration_ = 8.97

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108503058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10066ui_story = arg_237_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).z)
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles = arg_237_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_237_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10066ui_story"].transform.position).z)
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10066ui_story"].transform.localEulerAngles = arg_237_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["10066ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10066ui_story == nil then
				arg_237_1.var_.characterEffect10066ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect10066ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10066ui_story then
				arg_237_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_240_4 = 0
			local var_240_5 = 1.075

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(1108503057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 43 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 43)

				if (43 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 43)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")

						arg_237_1:RecordAudio("1108503057", var_240_11)
						arg_237_1:RecordAudio("1108503057", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108503058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108503058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1108503059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) and arg_241_1.var_.characterEffect10066ui_story == nil then
				arg_241_1.var_.characterEffect10066ui_story = arg_241_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) then
				if arg_241_1.var_.characterEffect10066ui_story and not isNil(arg_241_1.actors_["10066ui_story"]) then
					arg_241_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10066ui_story"]) and arg_241_1.var_.characterEffect10066ui_story then
				arg_241_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.675

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1108503058).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 27 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 27)

				if (27 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 27)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1108503059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108503059
		arg_245_1.duration_ = 2.07

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108503060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1085ui_story = arg_245_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).z)
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles = arg_245_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_245_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1085ui_story"].transform.position).z)
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1085ui_story"].transform.localEulerAngles = arg_245_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["10066ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10066ui_story = var_248_1.localPosition
			end

			local var_248_2 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 then
				var_248_1.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_245_1.time_ - 0) / var_248_2)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 then
				var_248_1.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			local var_248_3 = arg_245_1.actors_["1085ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_3) and arg_245_1.var_.characterEffect1085ui_story == nil then
				arg_245_1.var_.characterEffect1085ui_story = var_248_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_4 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 and not isNil(var_248_3) then
				if arg_245_1.var_.characterEffect1085ui_story and not isNil(var_248_3) then
					arg_245_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 and not isNil(var_248_3) and arg_245_1.var_.characterEffect1085ui_story then
				arg_245_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_248_6 = 0
			local var_248_7 = 0.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(1108503059)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 3 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 3)

				if (3 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 3)) > 0 and var_248_7 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb") ~= 0 then
					local var_248_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb") / 1000

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end

					if var_248_8.prefab_name ~= "" and arg_245_1.actors_[var_248_8.prefab_name] ~= nil then
						local var_248_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_8.prefab_name].transform, "story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")

						arg_245_1:RecordAudio("1108503059", var_248_13)
						arg_245_1:RecordAudio("1108503059", var_248_13)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1108503060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108503060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108503061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1085ui_story"]) and arg_249_1.var_.characterEffect1085ui_story == nil then
				arg_249_1.var_.characterEffect1085ui_story = arg_249_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1085ui_story"]) then
				if arg_249_1.var_.characterEffect1085ui_story and not isNil(arg_249_1.actors_["1085ui_story"]) then
					arg_249_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1085ui_story"]) and arg_249_1.var_.characterEffect1085ui_story then
				arg_249_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.775

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1108503060).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 31 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 31)

				if (31 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 31)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1108503061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108503061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1108503062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1108503061).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 46 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 46)

				if (46 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 46)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1108503062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1108503062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1108503063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.125

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1108503062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 45 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 45)

				if (45 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 45)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1108503063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108503063
		arg_261_1.duration_ = 5.2

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1108503064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1085ui_story = arg_261_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).z)
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles = arg_261_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_261_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1085ui_story"].transform.position).z)
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1085ui_story"].transform.localEulerAngles = arg_261_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1085ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1085ui_story == nil then
				arg_261_1.var_.characterEffect1085ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1085ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1085ui_story then
				arg_261_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0.034000001847744 < arg_261_1.time_ and arg_261_1.time_ <= 0.034000001847744 + arg_264_0 then
				arg_261_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_264_4 = 0
			local var_264_5 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(1108503063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)

				if (22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")

						arg_261_1:RecordAudio("1108503063", var_264_11)
						arg_261_1:RecordAudio("1108503063", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play1108503064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108503064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108503065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1085ui_story"]) and arg_265_1.var_.characterEffect1085ui_story == nil then
				arg_265_1.var_.characterEffect1085ui_story = arg_265_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1085ui_story"]) then
				if arg_265_1.var_.characterEffect1085ui_story and not isNil(arg_265_1.actors_["1085ui_story"]) then
					arg_265_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1085ui_story"]) and arg_265_1.var_.characterEffect1085ui_story then
				arg_265_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 0.55

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1108503064).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 22 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 22)

				if (22 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 22)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1108503065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108503065
		arg_269_1.duration_ = 4.67

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108503066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1085ui_story = arg_269_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).z)
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles = arg_269_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_269_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).z)
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles = arg_269_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1085ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1085ui_story == nil then
				arg_269_1.var_.characterEffect1085ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1085ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1085ui_story then
				arg_269_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.375

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(1108503065)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)

				if (15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")

						arg_269_1:RecordAudio("1108503065", var_272_11)
						arg_269_1:RecordAudio("1108503065", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play1108503066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108503066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108503067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1085ui_story"]) and arg_273_1.var_.characterEffect1085ui_story == nil then
				arg_273_1.var_.characterEffect1085ui_story = arg_273_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1085ui_story"]) then
				if arg_273_1.var_.characterEffect1085ui_story and not isNil(arg_273_1.actors_["1085ui_story"]) then
					arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1085ui_story"]) and arg_273_1.var_.characterEffect1085ui_story then
				arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.5

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

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1108503066).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 20 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 20)

				if (20 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 20)) > 0 and var_276_2 < var_276_5 then
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
	Play1108503067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108503067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108503068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.475

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1108503067).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 19 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 19)

				if (19 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 19)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108503068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1108503068
		arg_281_1.duration_ = 7.97

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1108503069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10066ui_story = arg_281_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).z)
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles = arg_281_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_281_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10066ui_story"].transform.position).z)
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10066ui_story"].transform.localEulerAngles = arg_281_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["10066ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10066ui_story == nil then
				arg_281_1.var_.characterEffect10066ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect10066ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10066ui_story then
				arg_281_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_4 = 0
			local var_284_5 = 0.925

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(1108503068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 37 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 37)

				if (37 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 37)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")

						arg_281_1:RecordAudio("1108503068", var_284_11)
						arg_281_1:RecordAudio("1108503068", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1108503069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1108503069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1108503070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10066ui_story = arg_285_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).z)
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles = arg_285_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10066ui_story"].transform.position).z)
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10066ui_story"].transform.localEulerAngles = arg_285_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1085ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1085ui_story = var_288_1.localPosition
			end

			local var_288_2 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 then
				var_288_1.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_2)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 then
				var_288_1.localPosition = Vector3.New(0, 100, 0)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			local var_288_3 = arg_285_1.actors_["10066ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect10066ui_story == nil then
				arg_285_1.var_.characterEffect10066ui_story = var_288_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_4 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 and not isNil(var_288_3) then
				if arg_285_1.var_.characterEffect10066ui_story and not isNil(var_288_3) then
					arg_285_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_4)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect10066ui_story then
				arg_285_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_288_5 = 0
			local var_288_6 = 0.875

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1108503069).content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 35 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_7) / 35)

				if (35 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_7) / 35)) > 0 and var_288_6 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_10 and arg_285_1.time_ < var_288_5 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_285_1:InitPlayNodeList()
	end,
	Play1108503070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1108503070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1108503071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.4

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

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1108503070).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 56 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 56)

				if (56 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 56)) > 0 and var_292_0 < var_292_3 then
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
	Play1108503071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108503071
		arg_293_1.duration_ = 9

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1108503072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if arg_293_1.bgs_.ST12a == nil then
				local var_296_0 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12a")
				var_296_0.name = "ST12a"
				var_296_0.transform.parent = arg_293_1.stage_.transform
				var_296_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_.ST12a = var_296_0
			end

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				local var_296_1 = arg_293_1.bgs_.ST12a

				arg_293_1.bgs_.ST12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_2 = var_296_1:GetComponent("SpriteRenderer")

				if var_296_2 and var_296_2.sprite then
					local var_296_3 = 2 * (var_296_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_1.transform.localScale = Vector3.New(var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST12a" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_4 = 3.999999999999

			if 3.999999999999 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_4 + 0.3 and arg_293_1.time_ < var_296_4 + 0.3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_5 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_6 = 2

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_5) / var_296_6)
				arg_293_1.mask_.color = var_296_7
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 then
				local var_296_8 = Color.New(0, 0, 0)

				var_296_8.a = 1
				arg_293_1.mask_.color = var_296_8
			end

			local var_296_9 = 2

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_10 = 2

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_10 then
				local var_296_11 = Color.New(0, 0, 0)

				var_296_11.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_9) / var_296_10)
				arg_293_1.mask_.color = var_296_11
			end

			if arg_293_1.time_ >= var_296_9 + var_296_10 and arg_293_1.time_ < var_296_9 + var_296_10 + arg_296_0 then
				local var_296_12 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_12.a = 0
				arg_293_1.mask_.color = var_296_12
			end

			if 0.266666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.266666666666667 + arg_296_0 then
				arg_293_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_296_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_15 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_15

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_15
						arg_293_1.bgmTxt2_.text = var_296_15
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_293_1.time_ and arg_293_1.time_ <= 1.7 + arg_296_0 then
				arg_293_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_296_18 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if "" ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_18 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_18

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_18
						arg_293_1.bgmTxt2_.text = var_296_18
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.266666666666667 + arg_296_0 then
				arg_293_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.7 < arg_293_1.time_ and arg_293_1.time_ <= 1.7 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_21 = 4
			local var_296_22 = 0.375

			if 4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_23 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_23:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_293_1.dialogCg_.alpha = arg_299_0
				end))
				var_296_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_24 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1108503071).content)

				arg_293_1.text_.text = var_296_24

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_26 = 15 <= 0 and var_296_22 or var_296_22 * (utf8.len(var_296_24) / 15)

				if (15 <= 0 and var_296_22 or var_296_22 * (utf8.len(var_296_24) / 15)) > 0 and var_296_22 < var_296_26 then
					arg_293_1.talkMaxDuration = var_296_26
					var_296_21 = var_296_21 + 0.3

					if var_296_26 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_26 + var_296_21
					end
				end

				arg_293_1.text_.text = var_296_24
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_27 = var_296_21 + 0.3
			local var_296_28 = math.max(var_296_22, arg_293_1.talkMaxDuration)

			if var_296_21 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_27 + var_296_28 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_27) / var_296_28

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_27 + var_296_28 and arg_293_1.time_ < var_296_27 + var_296_28 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1108503072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1108503072
		arg_301_1.duration_ = 2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1108503073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = arg_301_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).z)
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles = arg_301_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_301_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1085ui_story"].transform.position).z)
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1085ui_story"].transform.localEulerAngles = arg_301_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1085ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_304_4 = 0
			local var_304_5 = 0.15

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(1108503072)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 6 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 6)

				if (6 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 6)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")

						arg_301_1:RecordAudio("1108503072", var_304_11)
						arg_301_1:RecordAudio("1108503072", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play1108503073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1108503073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1108503074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1085ui_story = arg_305_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).z)
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles = arg_305_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1085ui_story"].transform.position).z)
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1085ui_story"].transform.localEulerAngles = arg_305_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1085ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1085ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_2)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1085ui_story then
				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_308_3 = 0
			local var_308_4 = 0.45

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1108503073).content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 18 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 18)

				if (18 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 18)) > 0 and var_308_4 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_3
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_4, arg_305_1.talkMaxDuration)

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_3) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_3 + var_308_8 and arg_305_1.time_ < var_308_3 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play1108503074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1108503074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1108503075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.45

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

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1108503074).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 18 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 18)

				if (18 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 18)) > 0 and var_312_0 < var_312_3 then
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
	Play1108503075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108503075
		arg_313_1.duration_ = 8.93

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1108503076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1085ui_story = arg_313_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).z)
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles = arg_313_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_313_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).z)
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles = arg_313_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1085ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1085ui_story == nil then
				arg_313_1.var_.characterEffect1085ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1085ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1085ui_story then
				arg_313_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.525

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1108503075)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 21 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 21)

				if (21 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 21)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")

						arg_313_1:RecordAudio("1108503075", var_316_11)
						arg_313_1:RecordAudio("1108503075", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play1108503076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108503076
		arg_317_1.duration_ = 9.57

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108503077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1085ui_story = arg_317_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).z)
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles = arg_317_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_317_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1085ui_story"].transform.position).z)
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1085ui_story"].transform.localEulerAngles = arg_317_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_1 = 0
			local var_320_2 = 0.75

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(1108503076)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_6 = 30 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_4) / 30)

				if (30 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_4) / 30)) > 0 and var_320_2 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb") ~= 0 then
					local var_320_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb") / 1000

					if var_320_7 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_1
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")

						arg_317_1:RecordAudio("1108503076", var_320_8)
						arg_317_1:RecordAudio("1108503076", var_320_8)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_9 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_9 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_9

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_9 and arg_317_1.time_ < var_320_1 + var_320_9 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play1108503077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108503077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108503078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1085ui_story"]) and arg_321_1.var_.characterEffect1085ui_story == nil then
				arg_321_1.var_.characterEffect1085ui_story = arg_321_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1085ui_story"]) then
				if arg_321_1.var_.characterEffect1085ui_story and not isNil(arg_321_1.actors_["1085ui_story"]) then
					arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1085ui_story"]) and arg_321_1.var_.characterEffect1085ui_story then
				arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.475

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1108503077).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 19 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 19)

				if (19 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 19)) > 0 and var_324_2 < var_324_5 then
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
	Play1108503078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108503078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108503079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1085ui_story = arg_325_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).z)
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles = arg_325_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1085ui_story"].transform.position).z)
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1085ui_story"].transform.localEulerAngles = arg_325_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_328_1 = 0
			local var_328_2 = 0.95

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1108503078).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 38 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 38)

				if (38 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 38)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play1108503079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108503079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108503080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.35

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1108503079).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 14 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 14)

				if (14 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 14)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108503080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108503080
		arg_333_1.duration_ = 14.97

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108503081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1085ui_story = arg_333_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).z)
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles = arg_333_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_333_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1085ui_story"].transform.position).z)
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1085ui_story"].transform.localEulerAngles = arg_333_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1085ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1085ui_story == nil then
				arg_333_1.var_.characterEffect1085ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1085ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1085ui_story then
				arg_333_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action423")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_336_4 = 0
			local var_336_5 = 1.15

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(1108503080)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 46 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 46)

				if (46 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 46)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")

						arg_333_1:RecordAudio("1108503080", var_336_11)
						arg_333_1:RecordAudio("1108503080", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play1108503081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108503081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108503082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) and arg_337_1.var_.characterEffect1085ui_story == nil then
				arg_337_1.var_.characterEffect1085ui_story = arg_337_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) then
				if arg_337_1.var_.characterEffect1085ui_story and not isNil(arg_337_1.actors_["1085ui_story"]) then
					arg_337_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) and arg_337_1.var_.characterEffect1085ui_story then
				arg_337_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.225

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1108503081).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 9 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 9)

				if (9 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 9)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108503082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108503082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108503083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1085ui_story = arg_341_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).z)
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles = arg_341_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1085ui_story"].transform.position).z)
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1085ui_story"].transform.localEulerAngles = arg_341_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_344_1 = 0
			local var_344_2 = 0.625

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1108503082).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 25 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 25)

				if (25 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 25)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play1108503083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108503083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108503084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.775

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1108503083).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 31)

				if (31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 31)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108503084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108503084
		arg_349_1.duration_ = 9.4

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108503085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1085ui_story = arg_349_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).z)
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles = arg_349_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_349_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1085ui_story"].transform.position).z)
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1085ui_story"].transform.localEulerAngles = arg_349_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1085ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1085ui_story == nil then
				arg_349_1.var_.characterEffect1085ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1085ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1085ui_story then
				arg_349_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_352_4 = 0
			local var_352_5 = 0.85

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(1108503084)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 34 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 34)

				if (34 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 34)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")

						arg_349_1:RecordAudio("1108503084", var_352_11)
						arg_349_1:RecordAudio("1108503084", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play1108503085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1108503085
		arg_353_1.duration_ = 6.7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1108503086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.6

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:GetWordFromCfg(1108503085)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 24 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 24)

				if (24 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 24)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")

						arg_353_1:RecordAudio("1108503085", var_356_6)
						arg_353_1:RecordAudio("1108503085", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1108503086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1108503086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1108503087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1085ui_story = arg_357_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).z)
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles = arg_357_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).z)
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles = arg_357_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1085ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1085ui_story == nil then
				arg_357_1.var_.characterEffect1085ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1085ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_2)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1085ui_story then
				arg_357_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_360_3 = 0
			local var_360_4 = 1.075

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_5 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1108503086).content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 43 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 43)

				if (43 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 43)) > 0 and var_360_4 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_3 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_3
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_4, arg_357_1.talkMaxDuration)

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_3) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_3 + var_360_8 and arg_357_1.time_ < var_360_3 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play1108503087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1108503087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1108503088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.925

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1108503087).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 37 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 37)

				if (37 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 37)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1108503088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1108503088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1108503089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1108503088).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 10)

				if (10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 10)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1108503089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1108503089
		arg_369_1.duration_ = 9

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1108503090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if arg_369_1.bgs_.ST12 == nil then
				local var_372_0 = Object.Instantiate(arg_369_1.paintGo_)

				var_372_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_372_0.name = "ST12"
				var_372_0.transform.parent = arg_369_1.stage_.transform
				var_372_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.bgs_.ST12 = var_372_0
			end

			if 2 < arg_369_1.time_ and arg_369_1.time_ <= 2 + arg_372_0 then
				local var_372_1 = arg_369_1.bgs_.ST12

				arg_369_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_372_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_2 = var_372_1:GetComponent("SpriteRenderer")

				if var_372_2 and var_372_2.sprite then
					local var_372_3 = 2 * (var_372_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_372_1.transform.localScale = Vector3.New(var_372_3 / var_372_2.sprite.bounds.size.y < var_372_3 * manager.ui.mainCameraCom_.aspect / var_372_2.sprite.bounds.size.x and var_372_3 * manager.ui.mainCameraCom_.aspect / var_372_2.sprite.bounds.size.x or var_372_3 / var_372_2.sprite.bounds.size.y, var_372_3 / var_372_2.sprite.bounds.size.y < var_372_3 * manager.ui.mainCameraCom_.aspect / var_372_2.sprite.bounds.size.x and var_372_3 * manager.ui.mainCameraCom_.aspect / var_372_2.sprite.bounds.size.x or var_372_3 / var_372_2.sprite.bounds.size.y, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "ST12" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_4 = 4

			if 4 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			if arg_369_1.time_ >= var_372_4 + 0.3 and arg_369_1.time_ < var_372_4 + 0.3 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			local var_372_5 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_6 = 2

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_6 then
				local var_372_7 = Color.New(0, 0, 0)

				var_372_7.a = Mathf.Lerp(0, 1, (arg_369_1.time_ - var_372_5) / var_372_6)
				arg_369_1.mask_.color = var_372_7
			end

			if arg_369_1.time_ >= var_372_5 + var_372_6 and arg_369_1.time_ < var_372_5 + var_372_6 + arg_372_0 then
				local var_372_8 = Color.New(0, 0, 0)

				var_372_8.a = 1
				arg_369_1.mask_.color = var_372_8
			end

			local var_372_9 = 2

			if 2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_10 = 2

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_10 then
				local var_372_11 = Color.New(0, 0, 0)

				var_372_11.a = Mathf.Lerp(1, 0, (arg_369_1.time_ - var_372_9) / var_372_10)
				arg_369_1.mask_.color = var_372_11
			end

			if arg_369_1.time_ >= var_372_9 + var_372_10 and arg_369_1.time_ < var_372_9 + var_372_10 + arg_372_0 then
				local var_372_12 = Color.New(0, 0, 0)

				arg_369_1.mask_.enabled = false
				var_372_12.a = 0
				arg_369_1.mask_.color = var_372_12
			end

			if 0.366666666666667 < arg_369_1.time_ and arg_369_1.time_ <= 0.366666666666667 + arg_372_0 then
				arg_369_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_372_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_369_1.bgmTxt_.text ~= var_372_15 and arg_369_1.bgmTxt_.text ~= "" then
						if arg_369_1.bgmTxt2_.text ~= "" then
							arg_369_1.bgmTxt_.text = arg_369_1.bgmTxt2_.text
						end

						arg_369_1.bgmTxt2_.text = var_372_15

						arg_369_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_369_1.bgmTxt_.text = var_372_15
						arg_369_1.bgmTxt2_.text = var_372_15
					end

					if arg_369_1.bgmTimer then
						arg_369_1.bgmTimer:Stop()

						arg_369_1.bgmTimer = nil
					end

					if arg_369_1.settingData.show_music_name == 1 then
						arg_369_1.musicController:SetSelectedState("show")
						arg_369_1.musicAnimator_:Play("open", 0, 0)

						if arg_369_1.settingData.music_time ~= 0 then
							arg_369_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_369_1.settingData.music_time), function()
								if arg_369_1 == nil or isNil(arg_369_1.bgmTxt_) then
									return
								end

								arg_369_1.musicController:SetSelectedState("hide")
								arg_369_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_16 = 4
			local var_372_17 = 0.675

			if 4 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_18 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_18:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_369_1.dialogCg_.alpha = arg_374_0
				end))
				var_372_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_19 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1108503089).content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_21 = 27 <= 0 and var_372_17 or var_372_17 * (utf8.len(var_372_19) / 27)

				if (27 <= 0 and var_372_17 or var_372_17 * (utf8.len(var_372_19) / 27)) > 0 and var_372_17 < var_372_21 then
					arg_369_1.talkMaxDuration = var_372_21
					var_372_16 = var_372_16 + 0.3

					if var_372_21 + var_372_16 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_21 + var_372_16
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_22 = var_372_16 + 0.3
			local var_372_23 = math.max(var_372_17, arg_369_1.talkMaxDuration)

			if var_372_16 + 0.3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_22 + var_372_23 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_22) / var_372_23

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_22 + var_372_23 and arg_369_1.time_ < var_372_22 + var_372_23 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1108503090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1108503090
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1108503091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 1.2

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(1108503090).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 48 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 48)

				if (48 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 48)) > 0 and var_379_0 < var_379_3 then
					arg_376_1.talkMaxDuration = var_379_3

					if var_379_3 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_3 + 0
					end
				end

				arg_376_1.text_.text = var_379_1
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_4 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_4

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1108503091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1108503091
		arg_380_1.duration_ = 10.27

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1108503092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if arg_380_1.bgs_.A00 == nil then
				local var_383_0 = Object.Instantiate(arg_380_1.paintGo_)

				var_383_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_383_0.name = "A00"
				var_383_0.transform.parent = arg_380_1.stage_.transform
				var_383_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.bgs_.A00 = var_383_0
			end

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 then
				local var_383_1 = arg_380_1.bgs_.A00

				arg_380_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_383_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_2 = var_383_1:GetComponent("SpriteRenderer")

				if var_383_2 and var_383_2.sprite then
					local var_383_3 = 2 * (var_383_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_383_1.transform.localScale = Vector3.New(var_383_3 / var_383_2.sprite.bounds.size.y < var_383_3 * manager.ui.mainCameraCom_.aspect / var_383_2.sprite.bounds.size.x and var_383_3 * manager.ui.mainCameraCom_.aspect / var_383_2.sprite.bounds.size.x or var_383_3 / var_383_2.sprite.bounds.size.y, var_383_3 / var_383_2.sprite.bounds.size.y < var_383_3 * manager.ui.mainCameraCom_.aspect / var_383_2.sprite.bounds.size.x and var_383_3 * manager.ui.mainCameraCom_.aspect / var_383_2.sprite.bounds.size.x or var_383_3 / var_383_2.sprite.bounds.size.y, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "A00" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_4 = 4

			if 4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			if arg_380_1.time_ >= var_383_4 + 0.3 and arg_380_1.time_ < var_383_4 + 0.3 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_5 = 0

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_6 = 2

			if var_383_5 <= arg_380_1.time_ and arg_380_1.time_ < var_383_5 + var_383_6 then
				local var_383_7 = Color.New(0, 0, 0)

				var_383_7.a = Mathf.Lerp(0, 1, (arg_380_1.time_ - var_383_5) / var_383_6)
				arg_380_1.mask_.color = var_383_7
			end

			if arg_380_1.time_ >= var_383_5 + var_383_6 and arg_380_1.time_ < var_383_5 + var_383_6 + arg_383_0 then
				local var_383_8 = Color.New(0, 0, 0)

				var_383_8.a = 1
				arg_380_1.mask_.color = var_383_8
			end

			local var_383_9 = 2

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_10 = 2

			if var_383_9 <= arg_380_1.time_ and arg_380_1.time_ < var_383_9 + var_383_10 then
				local var_383_11 = Color.New(0, 0, 0)

				var_383_11.a = Mathf.Lerp(1, 0, (arg_380_1.time_ - var_383_9) / var_383_10)
				arg_380_1.mask_.color = var_383_11
			end

			if arg_380_1.time_ >= var_383_9 + var_383_10 and arg_380_1.time_ < var_383_9 + var_383_10 + arg_383_0 then
				local var_383_12 = Color.New(0, 0, 0)

				arg_380_1.mask_.enabled = false
				var_383_12.a = 0
				arg_380_1.mask_.color = var_383_12
			end

			local var_383_13 = "1083ui_story"

			if arg_380_1.actors_["1083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1083ui_story"))) then
				local var_383_14 = Object.Instantiate(Asset.Load("Char/" .. "1083ui_story"), arg_380_1.stage_.transform)

				var_383_14.name = var_383_13
				var_383_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.actors_[var_383_13] = var_383_14

				local var_383_15 = var_383_14:GetComponentInChildren(typeof(CharacterEffect))

				var_383_15.enabled = true

				local var_383_16 = GameObjectTools.GetOrAddComponent(var_383_14, typeof(DynamicBoneHelper))

				if var_383_16 then
					var_383_16:EnableDynamicBone(false)
				end

				arg_380_1:ShowWeapon(var_383_15.transform, false)

				arg_380_1.var_[var_383_13 .. "Animator"] = var_383_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_380_1.var_[var_383_13 .. "Animator"].applyRootMotion = true
				arg_380_1.var_[var_383_13 .. "LipSync"] = var_383_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_383_17 = arg_380_1.actors_["1083ui_story"].transform

			if 3.8 < arg_380_1.time_ and arg_380_1.time_ <= 3.8 + arg_383_0 then
				arg_380_1.var_.moveOldPos1083ui_story = var_383_17.localPosition
			end

			local var_383_18 = 0.001

			if 3.8 <= arg_380_1.time_ and arg_380_1.time_ < 3.8 + var_383_18 then
				var_383_17.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1083ui_story, Vector3.New(0, -1.05, -6), (arg_380_1.time_ - 3.8) / var_383_18)
				var_383_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_17.position).x, (manager.ui.mainCamera.transform.position - var_383_17.position).y, (manager.ui.mainCamera.transform.position - var_383_17.position).z)
				var_383_17.localEulerAngles.z = 0
				var_383_17.localEulerAngles.x = 0
				var_383_17.localEulerAngles = var_383_17.localEulerAngles
			end

			if arg_380_1.time_ >= 3.8 + var_383_18 and arg_380_1.time_ < 3.8 + var_383_18 + arg_383_0 then
				var_383_17.localPosition = Vector3.New(0, -1.05, -6)
				var_383_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_17.position).x, (manager.ui.mainCamera.transform.position - var_383_17.position).y, (manager.ui.mainCamera.transform.position - var_383_17.position).z)
				var_383_17.localEulerAngles.z = 0
				var_383_17.localEulerAngles.x = 0
				var_383_17.localEulerAngles = var_383_17.localEulerAngles
			end

			local var_383_19 = arg_380_1.actors_["1083ui_story"]

			if 3.8 < arg_380_1.time_ and arg_380_1.time_ <= 3.8 + arg_383_0 and not isNil(var_383_19) and arg_380_1.var_.characterEffect1083ui_story == nil then
				arg_380_1.var_.characterEffect1083ui_story = var_383_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_20 = 0.200000002980232

			if 3.8 <= arg_380_1.time_ and arg_380_1.time_ < 3.8 + var_383_20 and not isNil(var_383_19) then
				if arg_380_1.var_.characterEffect1083ui_story and not isNil(var_383_19) then
					arg_380_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 3.8 + var_383_20 and arg_380_1.time_ < 3.8 + var_383_20 + arg_383_0 and not isNil(var_383_19) and arg_380_1.var_.characterEffect1083ui_story then
				arg_380_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			if 3.8 < arg_380_1.time_ and arg_380_1.time_ <= 3.8 + arg_383_0 then
				arg_380_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action5_1")
			end

			if 3.8 < arg_380_1.time_ and arg_380_1.time_ <= 3.8 + arg_383_0 then
				arg_380_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0.366666666666667 < arg_380_1.time_ and arg_380_1.time_ <= 0.366666666666667 + arg_383_0 then
				arg_380_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_383_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_24 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_24

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_24
						arg_380_1.bgmTxt2_.text = var_383_24
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.8 < arg_380_1.time_ and arg_380_1.time_ <= 1.8 + arg_383_0 then
				arg_380_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_383_27 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_27 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_27

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_27
						arg_380_1.bgmTxt2_.text = var_383_27
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_380_1.time_ and arg_380_1.time_ <= 0.366666666666667 + arg_383_0 then
				arg_380_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.8 < arg_380_1.time_ and arg_380_1.time_ <= 1.8 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_30 = 4
			local var_383_31 = 0.65

			if 4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_30 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_32 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_32:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_380_1.dialogCg_.alpha = arg_386_0
				end))
				var_383_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_33 = arg_380_1:GetWordFromCfg(1108503091)
				local var_383_34 = arg_380_1:FormatText(var_383_33.content)

				arg_380_1.text_.text = var_383_34

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_36 = 26 <= 0 and var_383_31 or var_383_31 * (utf8.len(var_383_34) / 26)

				if (26 <= 0 and var_383_31 or var_383_31 * (utf8.len(var_383_34) / 26)) > 0 and var_383_31 < var_383_36 then
					arg_380_1.talkMaxDuration = var_383_36
					var_383_30 = var_383_30 + 0.3

					if var_383_36 + var_383_30 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_36 + var_383_30
					end
				end

				arg_380_1.text_.text = var_383_34
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb") ~= 0 then
					local var_383_37 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb") / 1000

					if var_383_37 + var_383_30 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_37 + var_383_30
					end

					if var_383_33.prefab_name ~= "" and arg_380_1.actors_[var_383_33.prefab_name] ~= nil then
						local var_383_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_33.prefab_name].transform, "story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")

						arg_380_1:RecordAudio("1108503091", var_383_38)
						arg_380_1:RecordAudio("1108503091", var_383_38)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_39 = var_383_30 + 0.3
			local var_383_40 = math.max(var_383_31, arg_380_1.talkMaxDuration)

			if var_383_30 + 0.3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_39 + var_383_40 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_39) / var_383_40

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_39 + var_383_40 and arg_380_1.time_ < var_383_39 + var_383_40 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1108503092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1108503092
		arg_388_1.duration_ = 9.33

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1108503093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1083ui_story = arg_388_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1083ui_story, Vector3.New(0, -1.05, -6), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).z)
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles = arg_388_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_388_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1083ui_story"].transform.position).z)
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1083ui_story"].transform.localEulerAngles = arg_388_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083actionlink/1083action452")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_391_1 = 0
			local var_391_2 = 1.1

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:GetWordFromCfg(1108503092)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_6 = 44 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 44)

				if (44 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 44)) > 0 and var_391_2 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb") ~= 0 then
					local var_391_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb") / 1000

					if var_391_7 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_1
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")

						arg_388_1:RecordAudio("1108503092", var_391_8)
						arg_388_1:RecordAudio("1108503092", var_391_8)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_9 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_9 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_9

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_9 and arg_388_1.time_ < var_391_1 + var_391_9 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
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
	Play1108503093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1108503093
		arg_392_1.duration_ = 3.17

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1108503094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1085ui_story = arg_392_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).z)
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles = arg_392_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_392_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1085ui_story"].transform.position).z)
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1085ui_story"].transform.localEulerAngles = arg_392_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_395_1 = arg_392_1.actors_["1083ui_story"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1083ui_story = var_395_1.localPosition
			end

			local var_395_2 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_2 then
				var_395_1.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1083ui_story, Vector3.New(-0.7, -1.05, -6), (arg_392_1.time_ - 0) / var_395_2)
				var_395_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_1.position).x, (manager.ui.mainCamera.transform.position - var_395_1.position).y, (manager.ui.mainCamera.transform.position - var_395_1.position).z)
				var_395_1.localEulerAngles.z = 0
				var_395_1.localEulerAngles.x = 0
				var_395_1.localEulerAngles = var_395_1.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_2 and arg_392_1.time_ < 0 + var_395_2 + arg_395_0 then
				var_395_1.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_395_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_1.position).x, (manager.ui.mainCamera.transform.position - var_395_1.position).y, (manager.ui.mainCamera.transform.position - var_395_1.position).z)
				var_395_1.localEulerAngles.z = 0
				var_395_1.localEulerAngles.x = 0
				var_395_1.localEulerAngles = var_395_1.localEulerAngles
			end

			local var_395_3 = arg_392_1.actors_["1085ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect1085ui_story == nil then
				arg_392_1.var_.characterEffect1085ui_story = var_395_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_4 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 and not isNil(var_395_3) then
				if arg_392_1.var_.characterEffect1085ui_story and not isNil(var_395_3) then
					arg_392_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect1085ui_story then
				arg_392_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_395_6 = arg_392_1.actors_["1083ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect1083ui_story == nil then
				arg_392_1.var_.characterEffect1083ui_story = var_395_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_7 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 and not isNil(var_395_6) then
				if arg_392_1.var_.characterEffect1083ui_story and not isNil(var_395_6) then
					arg_392_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_7)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect1083ui_story then
				arg_392_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_395_8 = 0
			local var_395_9 = 0.325

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_10 = arg_392_1:GetWordFromCfg(1108503093)
				local var_395_11 = arg_392_1:FormatText(var_395_10.content)

				arg_392_1.text_.text = var_395_11

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_13 = 13 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 13)

				if (13 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 13)) > 0 and var_395_9 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_11
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb") / 1000

					if var_395_14 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_8
					end

					if var_395_10.prefab_name ~= "" and arg_392_1.actors_[var_395_10.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_10.prefab_name].transform, "story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")

						arg_392_1:RecordAudio("1108503093", var_395_15)
						arg_392_1:RecordAudio("1108503093", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_16 and arg_392_1.time_ < var_395_8 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1083ui_story",
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
	Play1108503094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1108503094
		arg_396_1.duration_ = 7.3

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1108503095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1083ui_story = arg_396_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1083ui_story, Vector3.New(-0.7, -1.05, -6), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).z)
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles = arg_396_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_396_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1083ui_story"].transform.position).z)
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1083ui_story"].transform.localEulerAngles = arg_396_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_399_1 = arg_396_1.actors_["1083ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect1083ui_story == nil then
				arg_396_1.var_.characterEffect1083ui_story = var_399_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_2 and not isNil(var_399_1) then
				if arg_396_1.var_.characterEffect1083ui_story and not isNil(var_399_1) then
					arg_396_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_2 and arg_396_1.time_ < 0 + var_399_2 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect1083ui_story then
				arg_396_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_399_4 = arg_396_1.actors_["1085ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_4) and arg_396_1.var_.characterEffect1085ui_story == nil then
				arg_396_1.var_.characterEffect1085ui_story = var_399_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_5 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_5 and not isNil(var_399_4) then
				if arg_396_1.var_.characterEffect1085ui_story and not isNil(var_399_4) then
					arg_396_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_5)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_5 and arg_396_1.time_ < 0 + var_399_5 + arg_399_0 and not isNil(var_399_4) and arg_396_1.var_.characterEffect1085ui_story then
				arg_396_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action2_2")
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_399_6 = 0
			local var_399_7 = 0.825

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_8 = arg_396_1:GetWordFromCfg(1108503094)
				local var_399_9 = arg_396_1:FormatText(var_399_8.content)

				arg_396_1.text_.text = var_399_9

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 33 <= 0 and var_399_7 or var_399_7 * (utf8.len(var_399_9) / 33)

				if (33 <= 0 and var_399_7 or var_399_7 * (utf8.len(var_399_9) / 33)) > 0 and var_399_7 < var_399_11 then
					arg_396_1.talkMaxDuration = var_399_11

					if var_399_11 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_11 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_9
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb") ~= 0 then
					local var_399_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb") / 1000

					if var_399_12 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_12 + var_399_6
					end

					if var_399_8.prefab_name ~= "" and arg_396_1.actors_[var_399_8.prefab_name] ~= nil then
						local var_399_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_8.prefab_name].transform, "story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")

						arg_396_1:RecordAudio("1108503094", var_399_13)
						arg_396_1:RecordAudio("1108503094", var_399_13)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_14 and arg_396_1.time_ < var_399_6 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play1108503095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1108503095
		arg_400_1.duration_ = 3.33

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1108503096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1083ui_story = arg_400_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1083ui_story, Vector3.New(-0.7, -1.05, -6), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).z)
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles = arg_400_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_400_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1083ui_story"].transform.position).z)
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1083ui_story"].transform.localEulerAngles = arg_400_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action6_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_403_1 = 0
			local var_403_2 = 0.65

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:GetWordFromCfg(1108503095)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_6 = 26 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_4) / 26)

				if (26 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_4) / 26)) > 0 and var_403_2 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_1
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb") ~= 0 then
					local var_403_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb") / 1000

					if var_403_7 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_1
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")

						arg_400_1:RecordAudio("1108503095", var_403_8)
						arg_400_1:RecordAudio("1108503095", var_403_8)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_9 = math.max(var_403_2, arg_400_1.talkMaxDuration)

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_9 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_1) / var_403_9

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_1 + var_403_9 and arg_400_1.time_ < var_403_1 + var_403_9 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1108503096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1108503096
		arg_404_1.duration_ = 3.1

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1108503097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1085ui_story = arg_404_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).z)
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles = arg_404_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_404_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1085ui_story"].transform.position).z)
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1085ui_story"].transform.localEulerAngles = arg_404_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1085ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1085ui_story == nil then
				arg_404_1.var_.characterEffect1085ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1085ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1085ui_story then
				arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_407_4 = arg_404_1.actors_["1083ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1083ui_story == nil then
				arg_404_1.var_.characterEffect1083ui_story = var_407_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_5 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_5 and not isNil(var_407_4) then
				if arg_404_1.var_.characterEffect1083ui_story and not isNil(var_407_4) then
					arg_404_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_5)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_5 and arg_404_1.time_ < 0 + var_407_5 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1083ui_story then
				arg_404_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_407_6 = 0
			local var_407_7 = 0.3

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_8 = arg_404_1:GetWordFromCfg(1108503096)
				local var_407_9 = arg_404_1:FormatText(var_407_8.content)

				arg_404_1.text_.text = var_407_9

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 12 <= 0 and var_407_7 or var_407_7 * (utf8.len(var_407_9) / 12)

				if (12 <= 0 and var_407_7 or var_407_7 * (utf8.len(var_407_9) / 12)) > 0 and var_407_7 < var_407_11 then
					arg_404_1.talkMaxDuration = var_407_11

					if var_407_11 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_11 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_9
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb") ~= 0 then
					local var_407_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb") / 1000

					if var_407_12 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_12 + var_407_6
					end

					if var_407_8.prefab_name ~= "" and arg_404_1.actors_[var_407_8.prefab_name] ~= nil then
						local var_407_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_8.prefab_name].transform, "story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")

						arg_404_1:RecordAudio("1108503096", var_407_13)
						arg_404_1:RecordAudio("1108503096", var_407_13)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_14 and arg_404_1.time_ < var_407_6 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play1108503097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1108503097
		arg_408_1.duration_ = 3.6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1108503098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos1083ui_story = arg_408_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_411_0 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 then
				arg_408_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1083ui_story, Vector3.New(-0.7, -1.05, -6), (arg_408_1.time_ - 0) / var_411_0)
				arg_408_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).z)
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles = arg_408_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 then
				arg_408_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_408_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1083ui_story"].transform.position).z)
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1083ui_story"].transform.localEulerAngles = arg_408_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_411_1 = arg_408_1.actors_["1083ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1083ui_story == nil then
				arg_408_1.var_.characterEffect1083ui_story = var_411_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_2 and not isNil(var_411_1) then
				if arg_408_1.var_.characterEffect1083ui_story and not isNil(var_411_1) then
					arg_408_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_2 and arg_408_1.time_ < 0 + var_411_2 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1083ui_story then
				arg_408_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_411_4 = arg_408_1.actors_["1085ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_4) and arg_408_1.var_.characterEffect1085ui_story == nil then
				arg_408_1.var_.characterEffect1085ui_story = var_411_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_5 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_5 and not isNil(var_411_4) then
				if arg_408_1.var_.characterEffect1085ui_story and not isNil(var_411_4) then
					arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_5)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_5 and arg_408_1.time_ < 0 + var_411_5 + arg_411_0 and not isNil(var_411_4) and arg_408_1.var_.characterEffect1085ui_story then
				arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action6_2")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_411_6 = 0
			local var_411_7 = 0.45

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_8 = arg_408_1:GetWordFromCfg(1108503097)
				local var_411_9 = arg_408_1:FormatText(var_411_8.content)

				arg_408_1.text_.text = var_411_9

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_11 = 18 <= 0 and var_411_7 or var_411_7 * (utf8.len(var_411_9) / 18)

				if (18 <= 0 and var_411_7 or var_411_7 * (utf8.len(var_411_9) / 18)) > 0 and var_411_7 < var_411_11 then
					arg_408_1.talkMaxDuration = var_411_11

					if var_411_11 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_11 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_9
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb") ~= 0 then
					local var_411_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb") / 1000

					if var_411_12 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_12 + var_411_6
					end

					if var_411_8.prefab_name ~= "" and arg_408_1.actors_[var_411_8.prefab_name] ~= nil then
						local var_411_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_8.prefab_name].transform, "story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")

						arg_408_1:RecordAudio("1108503097", var_411_13)
						arg_408_1:RecordAudio("1108503097", var_411_13)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_14 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_14 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_14

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_14 and arg_408_1.time_ < var_411_6 + var_411_14 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play1108503098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1108503098
		arg_412_1.duration_ = 2.3

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1108503099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if arg_412_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_415_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_412_1.stage_.transform)

				var_415_0.name = "10145ui_story"
				var_415_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_412_1.actors_["10145ui_story"] = var_415_0

				local var_415_1 = var_415_0:GetComponentInChildren(typeof(CharacterEffect))

				var_415_1.enabled = true

				local var_415_2 = GameObjectTools.GetOrAddComponent(var_415_0, typeof(DynamicBoneHelper))

				if var_415_2 then
					var_415_2:EnableDynamicBone(false)
				end

				arg_412_1:ShowWeapon(var_415_1.transform, false)

				arg_412_1.var_["10145ui_story" .. "Animator"] = var_415_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_412_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_412_1.var_["10145ui_story" .. "LipSync"] = var_415_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_415_3 = arg_412_1.actors_["10145ui_story"].transform

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10145ui_story = var_415_3.localPosition
			end

			local var_415_4 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				var_415_3.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_412_1.time_ - 0) / var_415_4)
				var_415_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_3.position).x, (manager.ui.mainCamera.transform.position - var_415_3.position).y, (manager.ui.mainCamera.transform.position - var_415_3.position).z)
				var_415_3.localEulerAngles.z = 0
				var_415_3.localEulerAngles.x = 0
				var_415_3.localEulerAngles = var_415_3.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				var_415_3.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_415_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_3.position).x, (manager.ui.mainCamera.transform.position - var_415_3.position).y, (manager.ui.mainCamera.transform.position - var_415_3.position).z)
				var_415_3.localEulerAngles.z = 0
				var_415_3.localEulerAngles.x = 0
				var_415_3.localEulerAngles = var_415_3.localEulerAngles
			end

			local var_415_5 = arg_412_1.actors_["1083ui_story"].transform

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1083ui_story = var_415_5.localPosition
			end

			local var_415_6 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_6 then
				var_415_5.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1083ui_story, Vector3.New(0, 100, 0), (arg_412_1.time_ - 0) / var_415_6)
				var_415_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_5.position).x, (manager.ui.mainCamera.transform.position - var_415_5.position).y, (manager.ui.mainCamera.transform.position - var_415_5.position).z)
				var_415_5.localEulerAngles.z = 0
				var_415_5.localEulerAngles.x = 0
				var_415_5.localEulerAngles = var_415_5.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_6 and arg_412_1.time_ < 0 + var_415_6 + arg_415_0 then
				var_415_5.localPosition = Vector3.New(0, 100, 0)
				var_415_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_5.position).x, (manager.ui.mainCamera.transform.position - var_415_5.position).y, (manager.ui.mainCamera.transform.position - var_415_5.position).z)
				var_415_5.localEulerAngles.z = 0
				var_415_5.localEulerAngles.x = 0
				var_415_5.localEulerAngles = var_415_5.localEulerAngles
			end

			local var_415_7 = arg_412_1.actors_["10145ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_7) and arg_412_1.var_.characterEffect10145ui_story == nil then
				arg_412_1.var_.characterEffect10145ui_story = var_415_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_8 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_8 and not isNil(var_415_7) then
				if arg_412_1.var_.characterEffect10145ui_story and not isNil(var_415_7) then
					arg_412_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_8 and arg_412_1.time_ < 0 + var_415_8 + arg_415_0 and not isNil(var_415_7) and arg_412_1.var_.characterEffect10145ui_story then
				arg_412_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_415_10 = arg_412_1.actors_["1083ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_10) and arg_412_1.var_.characterEffect1083ui_story == nil then
				arg_412_1.var_.characterEffect1083ui_story = var_415_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_11 and not isNil(var_415_10) then
				if arg_412_1.var_.characterEffect1083ui_story and not isNil(var_415_10) then
					arg_412_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_412_1.time_ - 0) / var_415_11)
				end
			end

			if arg_412_1.time_ >= 0 + var_415_11 and arg_412_1.time_ < 0 + var_415_11 + arg_415_0 and not isNil(var_415_10) and arg_412_1.var_.characterEffect1083ui_story then
				arg_412_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_415_12 = 0
			local var_415_13 = 0.3

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_12 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_14 = arg_412_1:GetWordFromCfg(1108503098)
				local var_415_15 = arg_412_1:FormatText(var_415_14.content)

				arg_412_1.text_.text = var_415_15

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_17 = 12 <= 0 and var_415_13 or var_415_13 * (utf8.len(var_415_15) / 12)

				if (12 <= 0 and var_415_13 or var_415_13 * (utf8.len(var_415_15) / 12)) > 0 and var_415_13 < var_415_17 then
					arg_412_1.talkMaxDuration = var_415_17

					if var_415_17 + var_415_12 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_17 + var_415_12
					end
				end

				arg_412_1.text_.text = var_415_15
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb") ~= 0 then
					local var_415_18 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb") / 1000

					if var_415_18 + var_415_12 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_18 + var_415_12
					end

					if var_415_14.prefab_name ~= "" and arg_412_1.actors_[var_415_14.prefab_name] ~= nil then
						local var_415_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_14.prefab_name].transform, "story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")

						arg_412_1:RecordAudio("1108503098", var_415_19)
						arg_412_1:RecordAudio("1108503098", var_415_19)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_20 = math.max(var_415_13, arg_412_1.talkMaxDuration)

			if var_415_12 <= arg_412_1.time_ and arg_412_1.time_ < var_415_12 + var_415_20 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_12) / var_415_20

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_12 + var_415_20 and arg_412_1.time_ < var_415_12 + var_415_20 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1108503099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1108503099
		arg_416_1.duration_ = 2.07

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1108503100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1085ui_story = arg_416_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).z)
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles = arg_416_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_416_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1085ui_story"].transform.position).z)
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1085ui_story"].transform.localEulerAngles = arg_416_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_419_1 = arg_416_1.actors_["1085ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1085ui_story == nil then
				arg_416_1.var_.characterEffect1085ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect1085ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1085ui_story then
				arg_416_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_419_4 = arg_416_1.actors_["10145ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_4) and arg_416_1.var_.characterEffect10145ui_story == nil then
				arg_416_1.var_.characterEffect10145ui_story = var_419_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_5 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_5 and not isNil(var_419_4) then
				if arg_416_1.var_.characterEffect10145ui_story and not isNil(var_419_4) then
					arg_416_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_416_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_5)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_5 and arg_416_1.time_ < 0 + var_419_5 + arg_419_0 and not isNil(var_419_4) and arg_416_1.var_.characterEffect10145ui_story then
				arg_416_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_416_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_419_6 = 0
			local var_419_7 = 0.125

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_8 = arg_416_1:GetWordFromCfg(1108503099)
				local var_419_9 = arg_416_1:FormatText(var_419_8.content)

				arg_416_1.text_.text = var_419_9

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 5 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 5)

				if (5 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 5)) > 0 and var_419_7 < var_419_11 then
					arg_416_1.talkMaxDuration = var_419_11

					if var_419_11 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_11 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_9
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb") ~= 0 then
					local var_419_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb") / 1000

					if var_419_12 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_12 + var_419_6
					end

					if var_419_8.prefab_name ~= "" and arg_416_1.actors_[var_419_8.prefab_name] ~= nil then
						local var_419_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_8.prefab_name].transform, "story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")

						arg_416_1:RecordAudio("1108503099", var_419_13)
						arg_416_1:RecordAudio("1108503099", var_419_13)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_14 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_14 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_14

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_14 and arg_416_1.time_ < var_419_6 + var_419_14 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play1108503100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1108503100
		arg_420_1.duration_ = 4.6

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1108503101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1083ui_story = arg_420_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1083ui_story, Vector3.New(0.7, -1.05, -6), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).z)
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles = arg_420_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6)
				arg_420_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1083ui_story"].transform.position).z)
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1083ui_story"].transform.localEulerAngles = arg_420_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["1085ui_story"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1085ui_story = var_423_1.localPosition
			end

			local var_423_2 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 then
				var_423_1.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_420_1.time_ - 0) / var_423_2)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 then
				var_423_1.localPosition = Vector3.New(0, 100, 0)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			local var_423_3 = arg_420_1.actors_["1083ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1083ui_story == nil then
				arg_420_1.var_.characterEffect1083ui_story = var_423_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_4 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 and not isNil(var_423_3) then
				if arg_420_1.var_.characterEffect1083ui_story and not isNil(var_423_3) then
					arg_420_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1083ui_story then
				arg_420_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_423_6 = arg_420_1.actors_["1085ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_6) and arg_420_1.var_.characterEffect1085ui_story == nil then
				arg_420_1.var_.characterEffect1085ui_story = var_423_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_7 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 and not isNil(var_423_6) then
				if arg_420_1.var_.characterEffect1085ui_story and not isNil(var_423_6) then
					arg_420_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_7)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 and not isNil(var_423_6) and arg_420_1.var_.characterEffect1085ui_story then
				arg_420_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action1_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_423_8 = 0
			local var_423_9 = 0.5

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_10 = arg_420_1:GetWordFromCfg(1108503100)
				local var_423_11 = arg_420_1:FormatText(var_423_10.content)

				arg_420_1.text_.text = var_423_11

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 20 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 20)

				if (20 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 20)) > 0 and var_423_9 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_11
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb") / 1000

					if var_423_14 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_8
					end

					if var_423_10.prefab_name ~= "" and arg_420_1.actors_[var_423_10.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_10.prefab_name].transform, "story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")

						arg_420_1:RecordAudio("1108503100", var_423_15)
						arg_420_1:RecordAudio("1108503100", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_16 and arg_420_1.time_ < var_423_8 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_420_1:InitPlayNodeList()
	end,
	Play1108503101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1108503101
		arg_424_1.duration_ = 4.73

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1108503102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10145ui_story = arg_424_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).z)
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles = arg_424_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_424_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10145ui_story"].transform.position).z)
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["10145ui_story"].transform.localEulerAngles = arg_424_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["10145ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect10145ui_story == nil then
				arg_424_1.var_.characterEffect10145ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect10145ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect10145ui_story then
				arg_424_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_427_4 = arg_424_1.actors_["1083ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1083ui_story == nil then
				arg_424_1.var_.characterEffect1083ui_story = var_427_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_5 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_5 and not isNil(var_427_4) then
				if arg_424_1.var_.characterEffect1083ui_story and not isNil(var_427_4) then
					arg_424_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_5)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_5 and arg_424_1.time_ < 0 + var_427_5 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1083ui_story then
				arg_424_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_427_6 = 0
			local var_427_7 = 0.65

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_8 = arg_424_1:GetWordFromCfg(1108503101)
				local var_427_9 = arg_424_1:FormatText(var_427_8.content)

				arg_424_1.text_.text = var_427_9

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 26 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 26)

				if (26 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 26)) > 0 and var_427_7 < var_427_11 then
					arg_424_1.talkMaxDuration = var_427_11

					if var_427_11 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_11 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_9
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb") ~= 0 then
					local var_427_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb") / 1000

					if var_427_12 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_6
					end

					if var_427_8.prefab_name ~= "" and arg_424_1.actors_[var_427_8.prefab_name] ~= nil then
						local var_427_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_8.prefab_name].transform, "story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")

						arg_424_1:RecordAudio("1108503101", var_427_13)
						arg_424_1:RecordAudio("1108503101", var_427_13)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play1108503102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1108503102
		arg_428_1.duration_ = 2

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1108503103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1083ui_story = arg_428_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1083ui_story, Vector3.New(0.7, -1.05, -6), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).z)
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles = arg_428_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6)
				arg_428_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1083ui_story"].transform.position).z)
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1083ui_story"].transform.localEulerAngles = arg_428_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_431_1 = arg_428_1.actors_["1083ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1083ui_story == nil then
				arg_428_1.var_.characterEffect1083ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect1083ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1083ui_story then
				arg_428_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_431_4 = arg_428_1.actors_["10145ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_4) and arg_428_1.var_.characterEffect10145ui_story == nil then
				arg_428_1.var_.characterEffect10145ui_story = var_431_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_5 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_5 and not isNil(var_431_4) then
				if arg_428_1.var_.characterEffect10145ui_story and not isNil(var_431_4) then
					arg_428_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_5)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_5 and arg_428_1.time_ < 0 + var_431_5 + arg_431_0 and not isNil(var_431_4) and arg_428_1.var_.characterEffect10145ui_story then
				arg_428_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action8_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_431_6 = 0
			local var_431_7 = 0.175

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_8 = arg_428_1:GetWordFromCfg(1108503102)
				local var_431_9 = arg_428_1:FormatText(var_431_8.content)

				arg_428_1.text_.text = var_431_9

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 7 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_9) / 7)

				if (7 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_9) / 7)) > 0 and var_431_7 < var_431_11 then
					arg_428_1.talkMaxDuration = var_431_11

					if var_431_11 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_11 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_9
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb") ~= 0 then
					local var_431_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb") / 1000

					if var_431_12 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_12 + var_431_6
					end

					if var_431_8.prefab_name ~= "" and arg_428_1.actors_[var_431_8.prefab_name] ~= nil then
						local var_431_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_8.prefab_name].transform, "story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")

						arg_428_1:RecordAudio("1108503102", var_431_13)
						arg_428_1:RecordAudio("1108503102", var_431_13)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play1108503103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1108503103
		arg_432_1.duration_ = 3.37

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1108503104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos1085ui_story = arg_432_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_435_0 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 then
				arg_432_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_432_1.time_ - 0) / var_435_0)
				arg_432_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).z)
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles = arg_432_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 then
				arg_432_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_432_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1085ui_story"].transform.position).z)
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1085ui_story"].transform.localEulerAngles = arg_432_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_435_1 = arg_432_1.actors_["10145ui_story"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10145ui_story = var_435_1.localPosition
			end

			local var_435_2 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_2 then
				var_435_1.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_432_1.time_ - 0) / var_435_2)
				var_435_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_1.position).x, (manager.ui.mainCamera.transform.position - var_435_1.position).y, (manager.ui.mainCamera.transform.position - var_435_1.position).z)
				var_435_1.localEulerAngles.z = 0
				var_435_1.localEulerAngles.x = 0
				var_435_1.localEulerAngles = var_435_1.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_2 and arg_432_1.time_ < 0 + var_435_2 + arg_435_0 then
				var_435_1.localPosition = Vector3.New(0, 100, 0)
				var_435_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_1.position).x, (manager.ui.mainCamera.transform.position - var_435_1.position).y, (manager.ui.mainCamera.transform.position - var_435_1.position).z)
				var_435_1.localEulerAngles.z = 0
				var_435_1.localEulerAngles.x = 0
				var_435_1.localEulerAngles = var_435_1.localEulerAngles
			end

			local var_435_3 = arg_432_1.actors_["1085ui_story"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_3) and arg_432_1.var_.characterEffect1085ui_story == nil then
				arg_432_1.var_.characterEffect1085ui_story = var_435_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_4 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 and not isNil(var_435_3) then
				if arg_432_1.var_.characterEffect1085ui_story and not isNil(var_435_3) then
					arg_432_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 and not isNil(var_435_3) and arg_432_1.var_.characterEffect1085ui_story then
				arg_432_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_435_6 = arg_432_1.actors_["1083ui_story"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_6) and arg_432_1.var_.characterEffect1083ui_story == nil then
				arg_432_1.var_.characterEffect1083ui_story = var_435_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_7 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 and not isNil(var_435_6) then
				if arg_432_1.var_.characterEffect1083ui_story and not isNil(var_435_6) then
					arg_432_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_7)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 and not isNil(var_435_6) and arg_432_1.var_.characterEffect1083ui_story then
				arg_432_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_435_8 = 0
			local var_435_9 = 0.225

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_8 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_10 = arg_432_1:GetWordFromCfg(1108503103)
				local var_435_11 = arg_432_1:FormatText(var_435_10.content)

				arg_432_1.text_.text = var_435_11

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_13 = 9 <= 0 and var_435_9 or var_435_9 * (utf8.len(var_435_11) / 9)

				if (9 <= 0 and var_435_9 or var_435_9 * (utf8.len(var_435_11) / 9)) > 0 and var_435_9 < var_435_13 then
					arg_432_1.talkMaxDuration = var_435_13

					if var_435_13 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_8
					end
				end

				arg_432_1.text_.text = var_435_11
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb") ~= 0 then
					local var_435_14 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb") / 1000

					if var_435_14 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_14 + var_435_8
					end

					if var_435_10.prefab_name ~= "" and arg_432_1.actors_[var_435_10.prefab_name] ~= nil then
						local var_435_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_10.prefab_name].transform, "story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")

						arg_432_1:RecordAudio("1108503103", var_435_15)
						arg_432_1:RecordAudio("1108503103", var_435_15)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_9, arg_432_1.talkMaxDuration)

			if var_435_8 <= arg_432_1.time_ and arg_432_1.time_ < var_435_8 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_8) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_8 + var_435_16 and arg_432_1.time_ < var_435_8 + var_435_16 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_432_1:InitPlayNodeList()
	end,
	Play1108503104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1108503104
		arg_436_1.duration_ = 3.47

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1108503105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos1083ui_story = arg_436_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1083ui_story, Vector3.New(0.7, -1.05, -6), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).z)
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles = arg_436_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6)
				arg_436_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1083ui_story"].transform.position).z)
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1083ui_story"].transform.localEulerAngles = arg_436_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_439_1 = arg_436_1.actors_["1083ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1083ui_story == nil then
				arg_436_1.var_.characterEffect1083ui_story = var_439_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_2 and not isNil(var_439_1) then
				if arg_436_1.var_.characterEffect1083ui_story and not isNil(var_439_1) then
					arg_436_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_2 and arg_436_1.time_ < 0 + var_439_2 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1083ui_story then
				arg_436_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_439_4 = arg_436_1.actors_["1085ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_4) and arg_436_1.var_.characterEffect1085ui_story == nil then
				arg_436_1.var_.characterEffect1085ui_story = var_439_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_5 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_5 and not isNil(var_439_4) then
				if arg_436_1.var_.characterEffect1085ui_story and not isNil(var_439_4) then
					arg_436_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_5)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_5 and arg_436_1.time_ < 0 + var_439_5 + arg_439_0 and not isNil(var_439_4) and arg_436_1.var_.characterEffect1085ui_story then
				arg_436_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action8_2")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_439_6 = 0
			local var_439_7 = 0.325

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_8 = arg_436_1:GetWordFromCfg(1108503104)
				local var_439_9 = arg_436_1:FormatText(var_439_8.content)

				arg_436_1.text_.text = var_439_9

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 13 <= 0 and var_439_7 or var_439_7 * (utf8.len(var_439_9) / 13)

				if (13 <= 0 and var_439_7 or var_439_7 * (utf8.len(var_439_9) / 13)) > 0 and var_439_7 < var_439_11 then
					arg_436_1.talkMaxDuration = var_439_11

					if var_439_11 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_11 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_9
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb") ~= 0 then
					local var_439_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb") / 1000

					if var_439_12 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_6
					end

					if var_439_8.prefab_name ~= "" and arg_436_1.actors_[var_439_8.prefab_name] ~= nil then
						local var_439_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_8.prefab_name].transform, "story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")

						arg_436_1:RecordAudio("1108503104", var_439_13)
						arg_436_1:RecordAudio("1108503104", var_439_13)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play1108503105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1108503105
		arg_440_1.duration_ = 7.9

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1108503106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1085ui_story = arg_440_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).z)
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles = arg_440_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_440_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1085ui_story"].transform.position).z)
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1085ui_story"].transform.localEulerAngles = arg_440_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1085ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1085ui_story == nil then
				arg_440_1.var_.characterEffect1085ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1085ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1085ui_story then
				arg_440_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_443_4 = arg_440_1.actors_["1083ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1083ui_story == nil then
				arg_440_1.var_.characterEffect1083ui_story = var_443_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_5 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_5 and not isNil(var_443_4) then
				if arg_440_1.var_.characterEffect1083ui_story and not isNil(var_443_4) then
					arg_440_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_5)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_5 and arg_440_1.time_ < 0 + var_443_5 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1083ui_story then
				arg_440_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_443_6 = 0
			local var_443_7 = 0.6

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_8 = arg_440_1:GetWordFromCfg(1108503105)
				local var_443_9 = arg_440_1:FormatText(var_443_8.content)

				arg_440_1.text_.text = var_443_9

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 24 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 24)

				if (24 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 24)) > 0 and var_443_7 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_9
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb") / 1000

					if var_443_12 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_6
					end

					if var_443_8.prefab_name ~= "" and arg_440_1.actors_[var_443_8.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_8.prefab_name].transform, "story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")

						arg_440_1:RecordAudio("1108503105", var_443_13)
						arg_440_1:RecordAudio("1108503105", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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

		arg_440_1:InitPlayNodeList()
	end,
	Play1108503106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1108503106
		arg_444_1.duration_ = 5.6

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1108503107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1085ui_story = arg_444_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).z)
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles = arg_444_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_444_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1085ui_story"].transform.position).z)
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1085ui_story"].transform.localEulerAngles = arg_444_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_447_1 = 0
			local var_447_2 = 0.375

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(1108503106)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 15 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 15)

				if (15 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 15)) > 0 and var_447_2 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb") ~= 0 then
					local var_447_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb") / 1000

					if var_447_7 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_1
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")

						arg_444_1:RecordAudio("1108503106", var_447_8)
						arg_444_1:RecordAudio("1108503106", var_447_8)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_9 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_9 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_9

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_9 and arg_444_1.time_ < var_447_1 + var_447_9 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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

		arg_444_1:InitPlayNodeList()
	end,
	Play1108503107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1108503107
		arg_448_1.duration_ = 2.67

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1108503108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos1083ui_story = arg_448_1.actors_["1083ui_story"].transform.localPosition
			end

			local var_451_0 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 then
				arg_448_1.actors_["1083ui_story"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1083ui_story, Vector3.New(0.7, -1.05, -6), (arg_448_1.time_ - 0) / var_451_0)
				arg_448_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).z)
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles = arg_448_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 then
				arg_448_1.actors_["1083ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6)
				arg_448_1.actors_["1083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1083ui_story"].transform.position).z)
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1083ui_story"].transform.localEulerAngles = arg_448_1.actors_["1083ui_story"].transform.localEulerAngles
			end

			local var_451_1 = arg_448_1.actors_["1083ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1083ui_story == nil then
				arg_448_1.var_.characterEffect1083ui_story = var_451_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 and not isNil(var_451_1) then
				if arg_448_1.var_.characterEffect1083ui_story and not isNil(var_451_1) then
					arg_448_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1083ui_story then
				arg_448_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_451_4 = arg_448_1.actors_["1085ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_4) and arg_448_1.var_.characterEffect1085ui_story == nil then
				arg_448_1.var_.characterEffect1085ui_story = var_451_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_5 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_5 and not isNil(var_451_4) then
				if arg_448_1.var_.characterEffect1085ui_story and not isNil(var_451_4) then
					arg_448_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_5)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_5 and arg_448_1.time_ < 0 + var_451_5 + arg_451_0 and not isNil(var_451_4) and arg_448_1.var_.characterEffect1085ui_story then
				arg_448_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action1_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0.200000002980232 < arg_448_1.time_ and arg_448_1.time_ <= 0.200000002980232 + arg_451_0 then
				arg_448_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_451_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_448_1.bgmTxt_.text ~= var_451_8 and arg_448_1.bgmTxt_.text ~= "" then
						if arg_448_1.bgmTxt2_.text ~= "" then
							arg_448_1.bgmTxt_.text = arg_448_1.bgmTxt2_.text
						end

						arg_448_1.bgmTxt2_.text = var_451_8

						arg_448_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_448_1.bgmTxt_.text = var_451_8
						arg_448_1.bgmTxt2_.text = var_451_8
					end

					if arg_448_1.bgmTimer then
						arg_448_1.bgmTimer:Stop()

						arg_448_1.bgmTimer = nil
					end

					if arg_448_1.settingData.show_music_name == 1 then
						arg_448_1.musicController:SetSelectedState("show")
						arg_448_1.musicAnimator_:Play("open", 0, 0)

						if arg_448_1.settingData.music_time ~= 0 then
							arg_448_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_448_1.settingData.music_time), function()
								if arg_448_1 == nil or isNil(arg_448_1.bgmTxt_) then
									return
								end

								arg_448_1.musicController:SetSelectedState("hide")
								arg_448_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_451_9 = 0
			local var_451_10 = 0.25

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_11 = arg_448_1:GetWordFromCfg(1108503107)
				local var_451_12 = arg_448_1:FormatText(var_451_11.content)

				arg_448_1.text_.text = var_451_12

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_14 = 10 <= 0 and var_451_10 or var_451_10 * (utf8.len(var_451_12) / 10)

				if (10 <= 0 and var_451_10 or var_451_10 * (utf8.len(var_451_12) / 10)) > 0 and var_451_10 < var_451_14 then
					arg_448_1.talkMaxDuration = var_451_14

					if var_451_14 + var_451_9 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_14 + var_451_9
					end
				end

				arg_448_1.text_.text = var_451_12
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb") ~= 0 then
					local var_451_15 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb") / 1000

					if var_451_15 + var_451_9 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_15 + var_451_9
					end

					if var_451_11.prefab_name ~= "" and arg_448_1.actors_[var_451_11.prefab_name] ~= nil then
						local var_451_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_11.prefab_name].transform, "story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")

						arg_448_1:RecordAudio("1108503107", var_451_16)
						arg_448_1:RecordAudio("1108503107", var_451_16)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_17 = math.max(var_451_10, arg_448_1.talkMaxDuration)

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_17 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_9) / var_451_17

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_9 + var_451_17 and arg_448_1.time_ < var_451_9 + var_451_17 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1108503108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108503108
		arg_453_1.duration_ = 11.83

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108503109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1085ui_story = arg_453_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).z)
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles = arg_453_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_453_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1085ui_story"].transform.position).z)
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1085ui_story"].transform.localEulerAngles = arg_453_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1085ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1085ui_story == nil then
				arg_453_1.var_.characterEffect1085ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1085ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1085ui_story then
				arg_453_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_456_4 = arg_453_1.actors_["1083ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect1083ui_story == nil then
				arg_453_1.var_.characterEffect1083ui_story = var_456_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_5 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_5 and not isNil(var_456_4) then
				if arg_453_1.var_.characterEffect1083ui_story and not isNil(var_456_4) then
					arg_453_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_5)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_5 and arg_453_1.time_ < 0 + var_456_5 + arg_456_0 and not isNil(var_456_4) and arg_453_1.var_.characterEffect1083ui_story then
				arg_453_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1083ui_story.fillRatio = 0.5
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_456_6 = 0
			local var_456_7 = 0.575

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_6 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_8 = arg_453_1:GetWordFromCfg(1108503108)
				local var_456_9 = arg_453_1:FormatText(var_456_8.content)

				arg_453_1.text_.text = var_456_9

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_11 = 23 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 23)

				if (23 <= 0 and var_456_7 or var_456_7 * (utf8.len(var_456_9) / 23)) > 0 and var_456_7 < var_456_11 then
					arg_453_1.talkMaxDuration = var_456_11

					if var_456_11 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_6
					end
				end

				arg_453_1.text_.text = var_456_9
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb") ~= 0 then
					local var_456_12 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb") / 1000

					if var_456_12 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_12 + var_456_6
					end

					if var_456_8.prefab_name ~= "" and arg_453_1.actors_[var_456_8.prefab_name] ~= nil then
						local var_456_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_8.prefab_name].transform, "story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")

						arg_453_1:RecordAudio("1108503108", var_456_13)
						arg_453_1:RecordAudio("1108503108", var_456_13)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_14 = math.max(var_456_7, arg_453_1.talkMaxDuration)

			if var_456_6 <= arg_453_1.time_ and arg_453_1.time_ < var_456_6 + var_456_14 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_6) / var_456_14

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_6 + var_456_14 and arg_453_1.time_ < var_456_6 + var_456_14 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play1108503109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108503109
		arg_457_1.duration_ = 9

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108503110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 2 < arg_457_1.time_ and arg_457_1.time_ <= 2 + arg_460_0 then
				local var_460_0 = arg_457_1.bgs_.B13

				arg_457_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_460_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_460_1 = var_460_0:GetComponent("SpriteRenderer")

				if var_460_1 and var_460_1.sprite then
					local var_460_2 = 2 * (var_460_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_460_0.transform.localScale = Vector3.New(var_460_2 / var_460_1.sprite.bounds.size.y < var_460_2 * manager.ui.mainCameraCom_.aspect / var_460_1.sprite.bounds.size.x and var_460_2 * manager.ui.mainCameraCom_.aspect / var_460_1.sprite.bounds.size.x or var_460_2 / var_460_1.sprite.bounds.size.y, var_460_2 / var_460_1.sprite.bounds.size.y < var_460_2 * manager.ui.mainCameraCom_.aspect / var_460_1.sprite.bounds.size.x and var_460_2 * manager.ui.mainCameraCom_.aspect / var_460_1.sprite.bounds.size.x or var_460_2 / var_460_1.sprite.bounds.size.y, 0)
				end

				for iter_460_0, iter_460_1 in pairs(arg_457_1.bgs_) do
					if iter_460_0 ~= "B13" then
						iter_460_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_460_3 = 4

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= var_460_3 + arg_460_0 then
				arg_457_1.allBtn_.enabled = false
			end

			if arg_457_1.time_ >= var_460_3 + 0.3 and arg_457_1.time_ < var_460_3 + 0.3 + arg_460_0 then
				arg_457_1.allBtn_.enabled = true
			end

			local var_460_4 = 0

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_5 = 2

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_5 then
				local var_460_6 = Color.New(0, 0, 0)

				var_460_6.a = Mathf.Lerp(0, 1, (arg_457_1.time_ - var_460_4) / var_460_5)
				arg_457_1.mask_.color = var_460_6
			end

			if arg_457_1.time_ >= var_460_4 + var_460_5 and arg_457_1.time_ < var_460_4 + var_460_5 + arg_460_0 then
				local var_460_7 = Color.New(0, 0, 0)

				var_460_7.a = 1
				arg_457_1.mask_.color = var_460_7
			end

			local var_460_8 = 2

			if 2 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_9 = 2

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_9 then
				local var_460_10 = Color.New(0, 0, 0)

				var_460_10.a = Mathf.Lerp(1, 0, (arg_457_1.time_ - var_460_8) / var_460_9)
				arg_457_1.mask_.color = var_460_10
			end

			if arg_457_1.time_ >= var_460_8 + var_460_9 and arg_457_1.time_ < var_460_8 + var_460_9 + arg_460_0 then
				local var_460_11 = Color.New(0, 0, 0)

				arg_457_1.mask_.enabled = false
				var_460_11.a = 0
				arg_457_1.mask_.color = var_460_11
			end

			local var_460_12 = arg_457_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_457_1.time_ and arg_457_1.time_ <= 1.96599999815226 + arg_460_0 then
				arg_457_1.var_.moveOldPos1085ui_story = var_460_12.localPosition
			end

			local var_460_13 = 0.001

			if 1.96599999815226 <= arg_457_1.time_ and arg_457_1.time_ < 1.96599999815226 + var_460_13 then
				var_460_12.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 1.96599999815226) / var_460_13)
				var_460_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_12.position).x, (manager.ui.mainCamera.transform.position - var_460_12.position).y, (manager.ui.mainCamera.transform.position - var_460_12.position).z)
				var_460_12.localEulerAngles.z = 0
				var_460_12.localEulerAngles.x = 0
				var_460_12.localEulerAngles = var_460_12.localEulerAngles
			end

			if arg_457_1.time_ >= 1.96599999815226 + var_460_13 and arg_457_1.time_ < 1.96599999815226 + var_460_13 + arg_460_0 then
				var_460_12.localPosition = Vector3.New(0, 100, 0)
				var_460_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_12.position).x, (manager.ui.mainCamera.transform.position - var_460_12.position).y, (manager.ui.mainCamera.transform.position - var_460_12.position).z)
				var_460_12.localEulerAngles.z = 0
				var_460_12.localEulerAngles.x = 0
				var_460_12.localEulerAngles = var_460_12.localEulerAngles
			end

			local var_460_14 = arg_457_1.actors_["1083ui_story"].transform

			if 1.96599999815226 < arg_457_1.time_ and arg_457_1.time_ <= 1.96599999815226 + arg_460_0 then
				arg_457_1.var_.moveOldPos1083ui_story = var_460_14.localPosition
			end

			local var_460_15 = 0.001

			if 1.96599999815226 <= arg_457_1.time_ and arg_457_1.time_ < 1.96599999815226 + var_460_15 then
				var_460_14.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1083ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 1.96599999815226) / var_460_15)
				var_460_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_14.position).x, (manager.ui.mainCamera.transform.position - var_460_14.position).y, (manager.ui.mainCamera.transform.position - var_460_14.position).z)
				var_460_14.localEulerAngles.z = 0
				var_460_14.localEulerAngles.x = 0
				var_460_14.localEulerAngles = var_460_14.localEulerAngles
			end

			if arg_457_1.time_ >= 1.96599999815226 + var_460_15 and arg_457_1.time_ < 1.96599999815226 + var_460_15 + arg_460_0 then
				var_460_14.localPosition = Vector3.New(0, 100, 0)
				var_460_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_14.position).x, (manager.ui.mainCamera.transform.position - var_460_14.position).y, (manager.ui.mainCamera.transform.position - var_460_14.position).z)
				var_460_14.localEulerAngles.z = 0
				var_460_14.localEulerAngles.x = 0
				var_460_14.localEulerAngles = var_460_14.localEulerAngles
			end

			local var_460_16 = arg_457_1.actors_["1085ui_story"]

			if 1.96599999815226 < arg_457_1.time_ and arg_457_1.time_ <= 1.96599999815226 + arg_460_0 and not isNil(var_460_16) and arg_457_1.var_.characterEffect1085ui_story == nil then
				arg_457_1.var_.characterEffect1085ui_story = var_460_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_17 = 0.034000001847744

			if 1.96599999815226 <= arg_457_1.time_ and arg_457_1.time_ < 1.96599999815226 + var_460_17 and not isNil(var_460_16) then
				if arg_457_1.var_.characterEffect1085ui_story and not isNil(var_460_16) then
					arg_457_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 1.96599999815226) / var_460_17)
				end
			end

			if arg_457_1.time_ >= 1.96599999815226 + var_460_17 and arg_457_1.time_ < 1.96599999815226 + var_460_17 + arg_460_0 and not isNil(var_460_16) and arg_457_1.var_.characterEffect1085ui_story then
				arg_457_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.333333333333333 < arg_457_1.time_ and arg_457_1.time_ <= 0.333333333333333 + arg_460_0 then
				arg_457_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 1.63333333333333 < arg_457_1.time_ and arg_457_1.time_ <= 1.63333333333333 + arg_460_0 then
				arg_457_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= 4 + arg_460_0 then
				arg_457_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_21 = 4
			local var_460_22 = 1

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= var_460_21 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_23 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_23:setOnUpdate(LuaHelper.FloatAction(function(arg_461_0)
					arg_457_1.dialogCg_.alpha = arg_461_0
				end))
				var_460_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_24 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1108503109).content)

				arg_457_1.text_.text = var_460_24

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_26 = 40 <= 0 and var_460_22 or var_460_22 * (utf8.len(var_460_24) / 40)

				if (40 <= 0 and var_460_22 or var_460_22 * (utf8.len(var_460_24) / 40)) > 0 and var_460_22 < var_460_26 then
					arg_457_1.talkMaxDuration = var_460_26
					var_460_21 = var_460_21 + 0.3

					if var_460_26 + var_460_21 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_26 + var_460_21
					end
				end

				arg_457_1.text_.text = var_460_24
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_27 = var_460_21 + 0.3
			local var_460_28 = math.max(var_460_22, arg_457_1.talkMaxDuration)

			if var_460_21 + 0.3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_27 + var_460_28 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_27) / var_460_28

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_27 + var_460_28 and arg_457_1.time_ < var_460_27 + var_460_28 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108503110 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1108503110
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1108503111(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.875

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1108503110).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 35 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 35)

				if (35 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 35)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1108503111 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108503111
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108503112(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.65

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1108503111).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 26 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 26)

				if (26 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 26)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108503112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108503112
		arg_471_1.duration_ = 8.03

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108503113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1085ui_story = arg_471_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).z)
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles = arg_471_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_471_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1085ui_story"].transform.position).z)
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1085ui_story"].transform.localEulerAngles = arg_471_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["1085ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1085ui_story == nil then
				arg_471_1.var_.characterEffect1085ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect1085ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1085ui_story then
				arg_471_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_474_4 = 0
			local var_474_5 = 0.5

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_6 = arg_471_1:GetWordFromCfg(1108503112)
				local var_474_7 = arg_471_1:FormatText(var_474_6.content)

				arg_471_1.text_.text = var_474_7

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_9 = 20 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 20)

				if (20 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 20)) > 0 and var_474_5 < var_474_9 then
					arg_471_1.talkMaxDuration = var_474_9

					if var_474_9 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_9 + var_474_4
					end
				end

				arg_471_1.text_.text = var_474_7
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb") ~= 0 then
					local var_474_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb") / 1000

					if var_474_10 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_4
					end

					if var_474_6.prefab_name ~= "" and arg_471_1.actors_[var_474_6.prefab_name] ~= nil then
						local var_474_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_6.prefab_name].transform, "story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")

						arg_471_1:RecordAudio("1108503112", var_474_11)
						arg_471_1:RecordAudio("1108503112", var_474_11)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_12 = math.max(var_474_5, arg_471_1.talkMaxDuration)

			if var_474_4 <= arg_471_1.time_ and arg_471_1.time_ < var_474_4 + var_474_12 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_4) / var_474_12

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_4 + var_474_12 and arg_471_1.time_ < var_474_4 + var_474_12 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
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

		arg_471_1:InitPlayNodeList()
	end,
	Play1108503113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108503113
		arg_475_1.duration_ = 11.8

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108503114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 1.999999999999 < arg_475_1.time_ and arg_475_1.time_ <= 1.999999999999 + arg_478_0 then
				local var_478_0 = arg_475_1.bgs_.ST12

				arg_475_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_478_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_478_1 = var_478_0:GetComponent("SpriteRenderer")

				if var_478_1 and var_478_1.sprite then
					local var_478_2 = 2 * (var_478_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_478_0.transform.localScale = Vector3.New(var_478_2 / var_478_1.sprite.bounds.size.y < var_478_2 * manager.ui.mainCameraCom_.aspect / var_478_1.sprite.bounds.size.x and var_478_2 * manager.ui.mainCameraCom_.aspect / var_478_1.sprite.bounds.size.x or var_478_2 / var_478_1.sprite.bounds.size.y, var_478_2 / var_478_1.sprite.bounds.size.y < var_478_2 * manager.ui.mainCameraCom_.aspect / var_478_1.sprite.bounds.size.x and var_478_2 * manager.ui.mainCameraCom_.aspect / var_478_1.sprite.bounds.size.x or var_478_2 / var_478_1.sprite.bounds.size.y, 0)
				end

				for iter_478_0, iter_478_1 in pairs(arg_475_1.bgs_) do
					if iter_478_0 ~= "ST12" then
						iter_478_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_478_3 = 3.999999999999

			if 3.999999999999 < arg_475_1.time_ and arg_475_1.time_ <= var_478_3 + arg_478_0 then
				arg_475_1.allBtn_.enabled = false
			end

			if arg_475_1.time_ >= var_478_3 + 0.3 and arg_475_1.time_ < var_478_3 + 0.3 + arg_478_0 then
				arg_475_1.allBtn_.enabled = true
			end

			local var_478_4 = 0

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_5 = 2

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_5 then
				local var_478_6 = Color.New(0, 0, 0)

				var_478_6.a = Mathf.Lerp(0, 1, (arg_475_1.time_ - var_478_4) / var_478_5)
				arg_475_1.mask_.color = var_478_6
			end

			if arg_475_1.time_ >= var_478_4 + var_478_5 and arg_475_1.time_ < var_478_4 + var_478_5 + arg_478_0 then
				local var_478_7 = Color.New(0, 0, 0)

				var_478_7.a = 1
				arg_475_1.mask_.color = var_478_7
			end

			local var_478_8 = 2

			if 2 < arg_475_1.time_ and arg_475_1.time_ <= var_478_8 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_9 = 2

			if var_478_8 <= arg_475_1.time_ and arg_475_1.time_ < var_478_8 + var_478_9 then
				local var_478_10 = Color.New(0, 0, 0)

				var_478_10.a = Mathf.Lerp(1, 0, (arg_475_1.time_ - var_478_8) / var_478_9)
				arg_475_1.mask_.color = var_478_10
			end

			if arg_475_1.time_ >= var_478_8 + var_478_9 and arg_475_1.time_ < var_478_8 + var_478_9 + arg_478_0 then
				local var_478_11 = Color.New(0, 0, 0)

				arg_475_1.mask_.enabled = false
				var_478_11.a = 0
				arg_475_1.mask_.color = var_478_11
			end

			local var_478_12 = arg_475_1.actors_["1085ui_story"].transform

			if 3.8 < arg_475_1.time_ and arg_475_1.time_ <= 3.8 + arg_478_0 then
				arg_475_1.var_.moveOldPos1085ui_story = var_478_12.localPosition
			end

			local var_478_13 = 0.001

			if 3.8 <= arg_475_1.time_ and arg_475_1.time_ < 3.8 + var_478_13 then
				var_478_12.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_475_1.time_ - 3.8) / var_478_13)
				var_478_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_12.position).x, (manager.ui.mainCamera.transform.position - var_478_12.position).y, (manager.ui.mainCamera.transform.position - var_478_12.position).z)
				var_478_12.localEulerAngles.z = 0
				var_478_12.localEulerAngles.x = 0
				var_478_12.localEulerAngles = var_478_12.localEulerAngles
			end

			if arg_475_1.time_ >= 3.8 + var_478_13 and arg_475_1.time_ < 3.8 + var_478_13 + arg_478_0 then
				var_478_12.localPosition = Vector3.New(0, -1.01, -5.83)
				var_478_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_12.position).x, (manager.ui.mainCamera.transform.position - var_478_12.position).y, (manager.ui.mainCamera.transform.position - var_478_12.position).z)
				var_478_12.localEulerAngles.z = 0
				var_478_12.localEulerAngles.x = 0
				var_478_12.localEulerAngles = var_478_12.localEulerAngles
			end

			local var_478_14 = arg_475_1.actors_["1085ui_story"]

			if 3.8 < arg_475_1.time_ and arg_475_1.time_ <= 3.8 + arg_478_0 and not isNil(var_478_14) and arg_475_1.var_.characterEffect1085ui_story == nil then
				arg_475_1.var_.characterEffect1085ui_story = var_478_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_15 = 0.200000002980232

			if 3.8 <= arg_475_1.time_ and arg_475_1.time_ < 3.8 + var_478_15 and not isNil(var_478_14) then
				if arg_475_1.var_.characterEffect1085ui_story and not isNil(var_478_14) then
					arg_475_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 3.8 + var_478_15 and arg_475_1.time_ < 3.8 + var_478_15 + arg_478_0 and not isNil(var_478_14) and arg_475_1.var_.characterEffect1085ui_story then
				arg_475_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.8 < arg_475_1.time_ and arg_475_1.time_ <= 3.8 + arg_478_0 then
				arg_475_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 3.8 < arg_475_1.time_ and arg_475_1.time_ <= 3.8 + arg_478_0 then
				arg_475_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_478_17 = arg_475_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_475_1.time_ and arg_475_1.time_ <= 1.96599999815226 + arg_478_0 then
				arg_475_1.var_.moveOldPos1085ui_story = var_478_17.localPosition
			end

			local var_478_18 = 0.001

			if 1.96599999815226 <= arg_475_1.time_ and arg_475_1.time_ < 1.96599999815226 + var_478_18 then
				var_478_17.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_475_1.time_ - 1.96599999815226) / var_478_18)
				var_478_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_17.position).x, (manager.ui.mainCamera.transform.position - var_478_17.position).y, (manager.ui.mainCamera.transform.position - var_478_17.position).z)
				var_478_17.localEulerAngles.z = 0
				var_478_17.localEulerAngles.x = 0
				var_478_17.localEulerAngles = var_478_17.localEulerAngles
			end

			if arg_475_1.time_ >= 1.96599999815226 + var_478_18 and arg_475_1.time_ < 1.96599999815226 + var_478_18 + arg_478_0 then
				var_478_17.localPosition = Vector3.New(0, 100, 0)
				var_478_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_17.position).x, (manager.ui.mainCamera.transform.position - var_478_17.position).y, (manager.ui.mainCamera.transform.position - var_478_17.position).z)
				var_478_17.localEulerAngles.z = 0
				var_478_17.localEulerAngles.x = 0
				var_478_17.localEulerAngles = var_478_17.localEulerAngles
			end

			if 0.333333333333333 < arg_475_1.time_ and arg_475_1.time_ <= 0.333333333333333 + arg_478_0 then
				arg_475_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1.7 < arg_475_1.time_ and arg_475_1.time_ <= 1.7 + arg_478_0 then
				arg_475_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_475_1.frameCnt_ <= 1 then
				arg_475_1.dialog_:SetActive(false)
			end

			local var_478_21 = 4
			local var_478_22 = 0.65

			if 4 < arg_475_1.time_ and arg_475_1.time_ <= var_478_21 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0

				arg_475_1.dialog_:SetActive(true)

				arg_475_1.dialogCg_.alpha = 0

				local var_478_23 = LeanTween.value(arg_475_1.dialog_, 0, 1, 0.3)

				var_478_23:setOnUpdate(LuaHelper.FloatAction(function(arg_479_0)
					arg_475_1.dialogCg_.alpha = arg_479_0
				end))
				var_478_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_475_1.dialog_)
					var_478_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_475_1.duration_ = arg_475_1.duration_ + 0.3

				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_24 = arg_475_1:GetWordFromCfg(1108503113)
				local var_478_25 = arg_475_1:FormatText(var_478_24.content)

				arg_475_1.text_.text = var_478_25

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_27 = 26 <= 0 and var_478_22 or var_478_22 * (utf8.len(var_478_25) / 26)

				if (26 <= 0 and var_478_22 or var_478_22 * (utf8.len(var_478_25) / 26)) > 0 and var_478_22 < var_478_27 then
					arg_475_1.talkMaxDuration = var_478_27
					var_478_21 = var_478_21 + 0.3

					if var_478_27 + var_478_21 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_27 + var_478_21
					end
				end

				arg_475_1.text_.text = var_478_25
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb") ~= 0 then
					local var_478_28 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb") / 1000

					if var_478_28 + var_478_21 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_28 + var_478_21
					end

					if var_478_24.prefab_name ~= "" and arg_475_1.actors_[var_478_24.prefab_name] ~= nil then
						local var_478_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_24.prefab_name].transform, "story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")

						arg_475_1:RecordAudio("1108503113", var_478_29)
						arg_475_1:RecordAudio("1108503113", var_478_29)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_30 = var_478_21 + 0.3
			local var_478_31 = math.max(var_478_22, arg_475_1.talkMaxDuration)

			if var_478_21 + 0.3 <= arg_475_1.time_ and arg_475_1.time_ < var_478_30 + var_478_31 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_30) / var_478_31

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_30 + var_478_31 and arg_475_1.time_ < var_478_30 + var_478_31 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_475_1:InitPlayNodeList()
	end,
	Play1108503114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108503114
		arg_481_1.duration_ = 4.93

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108503115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1085ui_story = arg_481_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).z)
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles = arg_481_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_481_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1085ui_story"].transform.position).z)
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1085ui_story"].transform.localEulerAngles = arg_481_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_484_1 = 0
			local var_484_2 = 0.45

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:GetWordFromCfg(1108503114)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 18 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 18)

				if (18 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 18)) > 0 and var_484_2 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb") ~= 0 then
					local var_484_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb") / 1000

					if var_484_7 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_1
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")

						arg_481_1:RecordAudio("1108503114", var_484_8)
						arg_481_1:RecordAudio("1108503114", var_484_8)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_9 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_9 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_9

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_9 and arg_481_1.time_ < var_484_1 + var_484_9 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play1108503115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108503115
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108503116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1085ui_story = arg_485_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).z)
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles = arg_485_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1085ui_story"].transform.position).z)
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1085ui_story"].transform.localEulerAngles = arg_485_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_488_1 = arg_485_1.actors_["1085ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1085ui_story == nil then
				arg_485_1.var_.characterEffect1085ui_story = var_488_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 and not isNil(var_488_1) then
				if arg_485_1.var_.characterEffect1085ui_story and not isNil(var_488_1) then
					arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_2)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1085ui_story then
				arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_488_3 = 0
			local var_488_4 = 0.55

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_3 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1108503115).content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 22 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 22)

				if (22 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 22)) > 0 and var_488_4 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_3 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_3
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_4, arg_485_1.talkMaxDuration)

			if var_488_3 <= arg_485_1.time_ and arg_485_1.time_ < var_488_3 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_3) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_3 + var_488_8 and arg_485_1.time_ < var_488_3 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play1108503116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108503116
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108503117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_492_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_2 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_2

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_2
						arg_489_1.bgmTxt2_.text = var_492_2
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_489_1.time_ and arg_489_1.time_ <= 0.3 + arg_492_0 then
				arg_489_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_492_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_5 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_5

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_5
						arg_489_1.bgmTxt2_.text = var_492_5
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_492_6 = 0
			local var_492_7 = 0.5

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_8 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1108503116).content)

				arg_489_1.text_.text = var_492_8

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_10 = 20 <= 0 and var_492_7 or var_492_7 * (utf8.len(var_492_8) / 20)

				if (20 <= 0 and var_492_7 or var_492_7 * (utf8.len(var_492_8) / 20)) > 0 and var_492_7 < var_492_10 then
					arg_489_1.talkMaxDuration = var_492_10

					if var_492_10 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_10 + var_492_6
					end
				end

				arg_489_1.text_.text = var_492_8
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_11 = math.max(var_492_7, arg_489_1.talkMaxDuration)

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_11 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_6) / var_492_11

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_6 + var_492_11 and arg_489_1.time_ < var_492_6 + var_492_11 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108503117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108503117
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108503118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.75

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1108503117).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 30 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 30)

				if (30 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 30)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108503118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1108503118
		arg_499_1.duration_ = 9.3

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1108503119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1085ui_story = arg_499_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).z)
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles = arg_499_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_499_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1085ui_story"].transform.position).z)
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1085ui_story"].transform.localEulerAngles = arg_499_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1085ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1085ui_story == nil then
				arg_499_1.var_.characterEffect1085ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1085ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1085ui_story then
				arg_499_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_502_4 = 0
			local var_502_5 = 0.875

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:GetWordFromCfg(1108503118)
				local var_502_7 = arg_499_1:FormatText(var_502_6.content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 35 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 35)

				if (35 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 35)) > 0 and var_502_5 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb") ~= 0 then
					local var_502_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb") / 1000

					if var_502_10 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_4
					end

					if var_502_6.prefab_name ~= "" and arg_499_1.actors_[var_502_6.prefab_name] ~= nil then
						local var_502_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_6.prefab_name].transform, "story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")

						arg_499_1:RecordAudio("1108503118", var_502_11)
						arg_499_1:RecordAudio("1108503118", var_502_11)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_12 and arg_499_1.time_ < var_502_4 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
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

		arg_499_1:InitPlayNodeList()
	end,
	Play1108503119 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108503119
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108503120(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) and arg_503_1.var_.characterEffect1085ui_story == nil then
				arg_503_1.var_.characterEffect1085ui_story = arg_503_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) then
				if arg_503_1.var_.characterEffect1085ui_story and not isNil(arg_503_1.actors_["1085ui_story"]) then
					arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1085ui_story"]) and arg_503_1.var_.characterEffect1085ui_story then
				arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.5

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1108503119).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 20 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 20)

				if (20 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 20)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1108503120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1108503120
		arg_507_1.duration_ = 12.4

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1108503121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1085ui_story = arg_507_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).z)
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles = arg_507_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_507_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1085ui_story"].transform.position).z)
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1085ui_story"].transform.localEulerAngles = arg_507_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1085ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1085ui_story == nil then
				arg_507_1.var_.characterEffect1085ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1085ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1085ui_story then
				arg_507_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_510_4 = 0
			local var_510_5 = 1.025

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_6 = arg_507_1:GetWordFromCfg(1108503120)
				local var_510_7 = arg_507_1:FormatText(var_510_6.content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_9 = 41 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 41)

				if (41 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 41)) > 0 and var_510_5 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9

					if var_510_9 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb") ~= 0 then
					local var_510_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb") / 1000

					if var_510_10 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_4
					end

					if var_510_6.prefab_name ~= "" and arg_507_1.actors_[var_510_6.prefab_name] ~= nil then
						local var_510_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_6.prefab_name].transform, "story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")

						arg_507_1:RecordAudio("1108503120", var_510_11)
						arg_507_1:RecordAudio("1108503120", var_510_11)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_12 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 <= arg_507_1.time_ and arg_507_1.time_ < var_510_4 + var_510_12 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_4) / var_510_12

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_4 + var_510_12 and arg_507_1.time_ < var_510_4 + var_510_12 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play1108503121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1108503121
		arg_511_1.duration_ = 7.83

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1108503122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1085ui_story = arg_511_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).z)
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles = arg_511_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_511_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1085ui_story"].transform.position).z)
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1085ui_story"].transform.localEulerAngles = arg_511_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_514_1 = 0
			local var_514_2 = 0.45

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:GetWordFromCfg(1108503121)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_6 = 18 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_4) / 18)

				if (18 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_4) / 18)) > 0 and var_514_2 < var_514_6 then
					arg_511_1.talkMaxDuration = var_514_6

					if var_514_6 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb") ~= 0 then
					local var_514_7 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb") / 1000

					if var_514_7 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_1
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")

						arg_511_1:RecordAudio("1108503121", var_514_8)
						arg_511_1:RecordAudio("1108503121", var_514_8)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_9 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_9 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_9

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_9 and arg_511_1.time_ < var_514_1 + var_514_9 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
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

		arg_511_1:InitPlayNodeList()
	end,
	Play1108503122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1108503122
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1108503123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = arg_515_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).z)
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles = arg_515_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_515_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1085ui_story"].transform.position).z)
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1085ui_story"].transform.localEulerAngles = arg_515_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1085ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1085ui_story == nil then
				arg_515_1.var_.characterEffect1085ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1085ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_2)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1085ui_story then
				arg_515_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_518_3 = 0
			local var_518_4 = 0.95

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_3 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_5 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1108503122).content)

				arg_515_1.text_.text = var_518_5

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_7 = 38 <= 0 and var_518_4 or var_518_4 * (utf8.len(var_518_5) / 38)

				if (38 <= 0 and var_518_4 or var_518_4 * (utf8.len(var_518_5) / 38)) > 0 and var_518_4 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_3 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_3
					end
				end

				arg_515_1.text_.text = var_518_5
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_8 = math.max(var_518_4, arg_515_1.talkMaxDuration)

			if var_518_3 <= arg_515_1.time_ and arg_515_1.time_ < var_518_3 + var_518_8 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_3) / var_518_8

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_3 + var_518_8 and arg_515_1.time_ < var_518_3 + var_518_8 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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

		arg_515_1:InitPlayNodeList()
	end,
	Play1108503123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1108503123
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1108503124(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.425

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(1108503123).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 17 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 17)

				if (17 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 17)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1108503124 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1108503124
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1108503125(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.4

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1108503124).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 16 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 16)

				if (16 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 16)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1108503125 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1108503125
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1108503126(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0.466666666666667 < arg_527_1.time_ and arg_527_1.time_ <= 0.466666666666667 + arg_530_0 then
				arg_527_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hug02", "")
			end

			local var_530_1 = 0
			local var_530_2 = 1.025

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_3 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1108503125).content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 41 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 41)

				if (41 <= 0 and var_530_2 or var_530_2 * (utf8.len(var_530_3) / 41)) > 0 and var_530_2 < var_530_5 then
					arg_527_1.talkMaxDuration = var_530_5

					if var_530_5 + var_530_1 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + var_530_1
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_6 = math.max(var_530_2, arg_527_1.talkMaxDuration)

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_6 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_1) / var_530_6

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_1 + var_530_6 and arg_527_1.time_ < var_530_1 + var_530_6 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1108503126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108503126
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108503127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.25

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1108503126).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 10 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 10)

				if (10 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 10)) > 0 and var_534_0 < var_534_3 then
					arg_531_1.talkMaxDuration = var_534_3

					if var_534_3 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_3 + 0
					end
				end

				arg_531_1.text_.text = var_534_1
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_4 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_4

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108503127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1108503127
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1108503128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.925

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_1 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1108503127).content)

				arg_535_1.text_.text = var_538_1

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_3 = 37 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 37)

				if (37 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 37)) > 0 and var_538_0 < var_538_3 then
					arg_535_1.talkMaxDuration = var_538_3

					if var_538_3 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_3 + 0
					end
				end

				arg_535_1.text_.text = var_538_1
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_4 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_4

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1108503128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1108503128
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1108503129(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.6

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1108503128).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 24 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 24)

				if (24 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 24)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1108503129 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108503129
		arg_543_1.duration_ = 2

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108503130(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos1085ui_story = arg_543_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_546_0 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 then
				arg_543_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_543_1.time_ - 0) / var_546_0)
				arg_543_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).z)
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles = arg_543_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 then
				arg_543_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_543_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1085ui_story"].transform.position).z)
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1085ui_story"].transform.localEulerAngles = arg_543_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_546_1 = arg_543_1.actors_["1085ui_story"]

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect1085ui_story == nil then
				arg_543_1.var_.characterEffect1085ui_story = var_546_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_2 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_2 and not isNil(var_546_1) then
				if arg_543_1.var_.characterEffect1085ui_story and not isNil(var_546_1) then
					arg_543_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_2 and arg_543_1.time_ < 0 + var_546_2 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect1085ui_story then
				arg_543_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_546_4 = 0
			local var_546_5 = 0.1

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_6 = arg_543_1:GetWordFromCfg(1108503129)
				local var_546_7 = arg_543_1:FormatText(var_546_6.content)

				arg_543_1.text_.text = var_546_7

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_9 = 4 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_7) / 4)

				if (4 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_7) / 4)) > 0 and var_546_5 < var_546_9 then
					arg_543_1.talkMaxDuration = var_546_9

					if var_546_9 + var_546_4 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_9 + var_546_4
					end
				end

				arg_543_1.text_.text = var_546_7
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb") ~= 0 then
					local var_546_10 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb") / 1000

					if var_546_10 + var_546_4 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_10 + var_546_4
					end

					if var_546_6.prefab_name ~= "" and arg_543_1.actors_[var_546_6.prefab_name] ~= nil then
						local var_546_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_6.prefab_name].transform, "story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")

						arg_543_1:RecordAudio("1108503129", var_546_11)
						arg_543_1:RecordAudio("1108503129", var_546_11)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_12 = math.max(var_546_5, arg_543_1.talkMaxDuration)

			if var_546_4 <= arg_543_1.time_ and arg_543_1.time_ < var_546_4 + var_546_12 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_4) / var_546_12

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_4 + var_546_12 and arg_543_1.time_ < var_546_4 + var_546_12 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
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

		arg_543_1:InitPlayNodeList()
	end,
	Play1108503130 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108503130
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108503131(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1085ui_story"]) and arg_547_1.var_.characterEffect1085ui_story == nil then
				arg_547_1.var_.characterEffect1085ui_story = arg_547_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1085ui_story"]) then
				if arg_547_1.var_.characterEffect1085ui_story and not isNil(arg_547_1.actors_["1085ui_story"]) then
					arg_547_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1085ui_story"]) and arg_547_1.var_.characterEffect1085ui_story then
				arg_547_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 0.975

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1108503130).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 39 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 39)

				if (39 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 39)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108503131 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108503131
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108503132(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.5

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1108503131).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 20 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 20)

				if (20 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 20)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108503132 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108503132
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
			arg_555_1.auto_ = false
		end

		function arg_555_1.playNext_(arg_557_0)
			arg_555_1.onStoryFinished_()
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1085ui_story = arg_555_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).z)
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles = arg_555_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1085ui_story"].transform.position).z)
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1085ui_story"].transform.localEulerAngles = arg_555_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0.274999999999 < arg_555_1.time_ and arg_555_1.time_ <= 0.274999999999 + arg_558_0 then
				arg_555_1:AudioAction("play", "effect", "se_story_148", "se_story_148_hold", "")
			end

			local var_558_2 = 0
			local var_558_3 = 1.275

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_4 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1108503132).content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_6 = 51 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_4) / 51)

				if (51 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_4) / 51)) > 0 and var_558_3 < var_558_6 then
					arg_555_1.talkMaxDuration = var_558_6

					if var_558_6 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_6 + var_558_2
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_7 = math.max(var_558_3, arg_555_1.talkMaxDuration)

			if var_558_2 <= arg_555_1.time_ and arg_555_1.time_ < var_558_2 + var_558_7 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_2) / var_558_7

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_2 + var_558_7 and arg_555_1.time_ < var_558_2 + var_558_7 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
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

		arg_555_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST20",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_new_1108503.awb"
	}
}
