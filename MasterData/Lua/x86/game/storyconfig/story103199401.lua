return {
	Play319941001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319941001
		arg_1_1.duration_ = 4.07

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319941002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST72 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72")
				var_4_0.name = "ST72"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST72 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST72

				arg_1_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST72" then
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

			local var_4_9 = "10075ui_story"

			if arg_1_1.actors_["10075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10075ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10075ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10075ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.715, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10075ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10075ui_story == nil then
				arg_1_1.var_.characterEffect10075ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10075ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10075ui_story then
				arg_1_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano")

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
			local var_4_25 = 0.15

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(319941001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 6 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 6)

				if (6 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 6)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941001", "story_v_out_319941.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_319941", "319941001", "story_v_out_319941.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_319941", "319941001", "story_v_out_319941.awb")

						arg_1_1:RecordAudio("319941001", var_4_32)
						arg_1_1:RecordAudio("319941001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319941", "319941001", "story_v_out_319941.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319941", "319941001", "story_v_out_319941.awb")
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
				actorName = "10075ui_story",
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
	Play319941002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319941002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319941003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10075ui_story"]) and arg_9_1.var_.characterEffect10075ui_story == nil then
				arg_9_1.var_.characterEffect10075ui_story = arg_9_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10075ui_story"]) then
				if arg_9_1.var_.characterEffect10075ui_story and not isNil(arg_9_1.actors_["10075ui_story"]) then
					arg_9_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10075ui_story"]) and arg_9_1.var_.characterEffect10075ui_story then
				arg_9_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_12_1 = arg_9_1.actors_["10075ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10075ui_story = var_12_1.localPosition
			end

			local var_12_2 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 then
				var_12_1.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_2)
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
			local var_12_4 = 0.825

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

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319941002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 33 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 33)

				if (33 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 33)) > 0 and var_12_4 < var_12_7 then
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
				actorName = "10075ui_story",
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
	Play319941003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319941003
		arg_13_1.duration_ = 5.67

		local var_13_0 = {
			zh = 3,
			ja = 5.666
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
				arg_13_0:Play319941004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10075ui_story = arg_13_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10075ui_story, Vector3.New(0.7, -0.715, -6.15), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).z)
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles = arg_13_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0.7, -0.715, -6.15)
				arg_13_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10075ui_story"].transform.position).z)
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10075ui_story"].transform.localEulerAngles = arg_13_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["10075ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10075ui_story == nil then
				arg_13_1.var_.characterEffect10075ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10075ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10075ui_story then
				arg_13_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_16_3 = "10069ui_story"

			if arg_13_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_16_4 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_13_1.stage_.transform)

				var_16_4.name = var_16_3
				var_16_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_3] = var_16_4

				local var_16_5 = var_16_4:GetComponentInChildren(typeof(CharacterEffect))

				var_16_5.enabled = true

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_4, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_5.transform, false)

				arg_13_1.var_[var_16_3 .. "Animator"] = var_16_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_3 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_3 .. "LipSync"] = var_16_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_7 = arg_13_1.actors_["10069ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10069ui_story = var_16_7.localPosition
			end

			local var_16_8 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 then
				var_16_7.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_13_1.time_ - 0) / var_16_8)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 then
				var_16_7.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			local var_16_9 = arg_13_1.actors_["10069ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10069ui_story == nil then
				arg_13_1.var_.characterEffect10069ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_10 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 and not isNil(var_16_9) then
				if arg_13_1.var_.characterEffect10069ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10069ui_story then
				arg_13_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_16_12 = 0
			local var_16_13 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(319941003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 14 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 14)

				if (14 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 14)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941003", "story_v_out_319941.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_319941", "319941003", "story_v_out_319941.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_319941", "319941003", "story_v_out_319941.awb")

						arg_13_1:RecordAudio("319941003", var_16_19)
						arg_13_1:RecordAudio("319941003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319941", "319941003", "story_v_out_319941.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319941", "319941003", "story_v_out_319941.awb")
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319941004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319941004
		arg_17_1.duration_ = 3.67

		local var_17_0 = {
			zh = 2.566,
			ja = 3.666
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
				arg_17_0:Play319941005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10069ui_story"]) and arg_17_1.var_.characterEffect10069ui_story == nil then
				arg_17_1.var_.characterEffect10069ui_story = arg_17_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10069ui_story"]) then
				if arg_17_1.var_.characterEffect10069ui_story and not isNil(arg_17_1.actors_["10069ui_story"]) then
					arg_17_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10069ui_story"]) and arg_17_1.var_.characterEffect10069ui_story then
				arg_17_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_20_1 = arg_17_1.actors_["10075ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10075ui_story == nil then
				arg_17_1.var_.characterEffect10075ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10075ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10075ui_story then
				arg_17_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(319941004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 11 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 11)

				if (11 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 11)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941004", "story_v_out_319941.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941004", "story_v_out_319941.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319941", "319941004", "story_v_out_319941.awb")

						arg_17_1:RecordAudio("319941004", var_20_11)
						arg_17_1:RecordAudio("319941004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319941", "319941004", "story_v_out_319941.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319941", "319941004", "story_v_out_319941.awb")
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

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319941005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319941005
		arg_21_1.duration_ = 8.5

		local var_21_0 = {
			zh = 5.366,
			ja = 8.5
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
				arg_21_0:Play319941006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) and arg_21_1.var_.characterEffect10069ui_story == nil then
				arg_21_1.var_.characterEffect10069ui_story = arg_21_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) then
				if arg_21_1.var_.characterEffect10069ui_story and not isNil(arg_21_1.actors_["10069ui_story"]) then
					arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) and arg_21_1.var_.characterEffect10069ui_story then
				arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["10075ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10075ui_story == nil then
				arg_21_1.var_.characterEffect10075ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect10075ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10075ui_story then
				arg_21_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319941005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)

				if (25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941005", "story_v_out_319941.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941005", "story_v_out_319941.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319941", "319941005", "story_v_out_319941.awb")

						arg_21_1:RecordAudio("319941005", var_24_11)
						arg_21_1:RecordAudio("319941005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319941", "319941005", "story_v_out_319941.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319941", "319941005", "story_v_out_319941.awb")
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
	Play319941006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319941006
		arg_25_1.duration_ = 4.07

		local var_25_0 = {
			zh = 2,
			ja = 4.066
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
				arg_25_0:Play319941007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10075ui_story"]) and arg_25_1.var_.characterEffect10075ui_story == nil then
				arg_25_1.var_.characterEffect10075ui_story = arg_25_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10075ui_story"]) then
				if arg_25_1.var_.characterEffect10075ui_story and not isNil(arg_25_1.actors_["10075ui_story"]) then
					arg_25_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10075ui_story"]) and arg_25_1.var_.characterEffect10075ui_story then
				arg_25_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action442")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_28_2 = arg_25_1.actors_["10069ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10069ui_story == nil then
				arg_25_1.var_.characterEffect10069ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect10069ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10069ui_story then
				arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(319941006)
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

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941006", "story_v_out_319941.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941006", "story_v_out_319941.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319941", "319941006", "story_v_out_319941.awb")

						arg_25_1:RecordAudio("319941006", var_28_11)
						arg_25_1:RecordAudio("319941006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319941", "319941006", "story_v_out_319941.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319941", "319941006", "story_v_out_319941.awb")
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
	Play319941007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319941007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319941008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10075ui_story = arg_29_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).z)
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles = arg_29_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10075ui_story"].transform.position).z)
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10075ui_story"].transform.localEulerAngles = arg_29_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10075ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10075ui_story == nil then
				arg_29_1.var_.characterEffect10075ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10075ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10075ui_story then
				arg_29_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_32_3 = arg_29_1.actors_["10069ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10069ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, 100, 0)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["10069ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10069ui_story == nil then
				arg_29_1.var_.characterEffect10069ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10069ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_6)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10069ui_story then
				arg_29_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_32_7 = 0
			local var_32_8 = 1.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319941007).content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 53 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 53)

				if (53 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 53)) > 0 and var_32_8 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_12 and arg_29_1.time_ < var_32_7 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319941008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319941008
		arg_33_1.duration_ = 6.97

		local var_33_0 = {
			zh = 2.733,
			ja = 6.966
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
				arg_33_0:Play319941009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1084ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1084ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1084ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1084ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1084ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1084ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -0.97, -6)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1084ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_36_8 = 0
			local var_36_9 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(319941008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 15 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 15)

				if (15 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 15)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941008", "story_v_out_319941.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941008", "story_v_out_319941.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_319941", "319941008", "story_v_out_319941.awb")

						arg_33_1:RecordAudio("319941008", var_36_15)
						arg_33_1:RecordAudio("319941008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319941", "319941008", "story_v_out_319941.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319941", "319941008", "story_v_out_319941.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319941009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319941009
		arg_37_1.duration_ = 8.43

		local var_37_0 = {
			zh = 4.7,
			ja = 8.433
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
				arg_37_0:Play319941010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = arg_37_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1084ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_40_3 = arg_37_1.actors_["10075ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10075ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10075ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10075ui_story == nil then
				arg_37_1.var_.characterEffect10075ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10075ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10075ui_story then
				arg_37_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_8 = 0
			local var_40_9 = 0.55

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(319941009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 22 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 22)

				if (22 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 22)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941009", "story_v_out_319941.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941009", "story_v_out_319941.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_319941", "319941009", "story_v_out_319941.awb")

						arg_37_1:RecordAudio("319941009", var_40_15)
						arg_37_1:RecordAudio("319941009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319941", "319941009", "story_v_out_319941.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319941", "319941009", "story_v_out_319941.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
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
	Play319941010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319941010
		arg_41_1.duration_ = 5.37

		local var_41_0 = {
			zh = 2.7,
			ja = 5.366
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
				arg_41_0:Play319941011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = arg_41_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(arg_41_1.actors_["1084ui_story"]) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["10075ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10075ui_story == nil then
				arg_41_1.var_.characterEffect10075ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect10075ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10075ui_story then
				arg_41_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(319941010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 16 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 16)

				if (16 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 16)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941010", "story_v_out_319941.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941010", "story_v_out_319941.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_319941", "319941010", "story_v_out_319941.awb")

						arg_41_1:RecordAudio("319941010", var_44_11)
						arg_41_1:RecordAudio("319941010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319941", "319941010", "story_v_out_319941.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319941", "319941010", "story_v_out_319941.awb")
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

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319941011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319941011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319941012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10075ui_story = arg_45_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).z)
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles = arg_45_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10075ui_story"].transform.position).z)
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10075ui_story"].transform.localEulerAngles = arg_45_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1084ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1084ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(319941011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 37 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 37)

				if (37 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 37)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play319941012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319941012
		arg_49_1.duration_ = 8

		local var_49_0 = {
			zh = 2.066,
			ja = 8
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
				arg_49_0:Play319941013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10050")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(319941012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 10)

				if (10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 10)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941012", "story_v_out_319941.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941012", "story_v_out_319941.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_319941", "319941012", "story_v_out_319941.awb")

						arg_49_1:RecordAudio("319941012", var_52_6)
						arg_49_1:RecordAudio("319941012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319941", "319941012", "story_v_out_319941.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319941", "319941012", "story_v_out_319941.awb")
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
	Play319941013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319941013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play319941014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.025

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(319941013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 41)

				if (41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 41)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319941014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319941014
		arg_57_1.duration_ = 4.43

		local var_57_0 = {
			zh = 2.833,
			ja = 4.433
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
				arg_57_0:Play319941015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10069ui_story = arg_57_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).z)
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles = arg_57_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6.33)
				arg_57_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10069ui_story"].transform.position).z)
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10069ui_story"].transform.localEulerAngles = arg_57_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10069ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10069ui_story == nil then
				arg_57_1.var_.characterEffect10069ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10069ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10069ui_story then
				arg_57_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(319941014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 14 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 14)

				if (14 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 14)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941014", "story_v_out_319941.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941014", "story_v_out_319941.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_319941", "319941014", "story_v_out_319941.awb")

						arg_57_1:RecordAudio("319941014", var_60_11)
						arg_57_1:RecordAudio("319941014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319941", "319941014", "story_v_out_319941.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319941", "319941014", "story_v_out_319941.awb")
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319941015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319941015
		arg_61_1.duration_ = 4.73

		local var_61_0 = {
			zh = 4.5,
			ja = 4.733
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
				arg_61_0:Play319941016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = arg_61_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1084ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_64_4 = arg_61_1.actors_["10069ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10069ui_story = var_64_4.localPosition
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_4.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_5)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_4.localPosition = Vector3.New(0, 100, 0)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			local var_64_6 = arg_61_1.actors_["10069ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect10069ui_story == nil then
				arg_61_1.var_.characterEffect10069ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect10069ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect10069ui_story then
				arg_61_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_64_8 = 0
			local var_64_9 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
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

				local var_64_10 = arg_61_1:GetWordFromCfg(319941015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 16 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 16)

				if (16 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 16)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941015", "story_v_out_319941.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941015", "story_v_out_319941.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_319941", "319941015", "story_v_out_319941.awb")

						arg_61_1:RecordAudio("319941015", var_64_15)
						arg_61_1:RecordAudio("319941015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319941", "319941015", "story_v_out_319941.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319941", "319941015", "story_v_out_319941.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
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
	Play319941016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319941016
		arg_65_1.duration_ = 6.2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play319941017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.bgs_.D02a == nil then
				local var_68_0 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_68_0.name = "D02a"
				var_68_0.transform.parent = arg_65_1.stage_.transform
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_.D02a = var_68_0
			end

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_1 = arg_65_1.bgs_.D02a

				arg_65_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_2 = var_68_1:GetComponent("SpriteRenderer")

				if var_68_2 and var_68_2.sprite then
					local var_68_3 = 2 * (var_68_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_1.transform.localScale = Vector3.New(var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "D02a" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_4 = 4

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_4 + 0.3 and arg_65_1.time_ < var_68_4 + 0.3 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_5 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_6 = 2

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_5) / var_68_6)
				arg_65_1.mask_.color = var_68_7
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 then
				local var_68_8 = Color.New(0, 0, 0)

				var_68_8.a = 1
				arg_65_1.mask_.color = var_68_8
			end

			local var_68_9 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 then
				local var_68_11 = Color.New(0, 0, 0)

				var_68_11.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_9) / var_68_10)
				arg_65_1.mask_.color = var_68_11
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 then
				local var_68_12 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_12.a = 0
				arg_65_1.mask_.color = var_68_12
			end

			local var_68_13 = arg_65_1.actors_["1084ui_story"].transform

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_13.localPosition
			end

			local var_68_14 = 0.001

			if 3.8 <= arg_65_1.time_ and arg_65_1.time_ < 3.8 + var_68_14 then
				var_68_13.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_65_1.time_ - 3.8) / var_68_14)
				var_68_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_13.position).x, (manager.ui.mainCamera.transform.position - var_68_13.position).y, (manager.ui.mainCamera.transform.position - var_68_13.position).z)
				var_68_13.localEulerAngles.z = 0
				var_68_13.localEulerAngles.x = 0
				var_68_13.localEulerAngles = var_68_13.localEulerAngles
			end

			if arg_65_1.time_ >= 3.8 + var_68_14 and arg_65_1.time_ < 3.8 + var_68_14 + arg_68_0 then
				var_68_13.localPosition = Vector3.New(0, -0.97, -6)
				var_68_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_13.position).x, (manager.ui.mainCamera.transform.position - var_68_13.position).y, (manager.ui.mainCamera.transform.position - var_68_13.position).z)
				var_68_13.localEulerAngles.z = 0
				var_68_13.localEulerAngles.x = 0
				var_68_13.localEulerAngles = var_68_13.localEulerAngles
			end

			local var_68_15 = arg_65_1.actors_["1084ui_story"]

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_16 = 0.200000002980232

			if 3.8 <= arg_65_1.time_ and arg_65_1.time_ < 3.8 + var_68_16 and not isNil(var_68_15) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_15) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 3.8 + var_68_16 and arg_65_1.time_ < 3.8 + var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 3.8 < arg_65_1.time_ and arg_65_1.time_ <= 3.8 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_18 = arg_65_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_65_1.time_ and arg_65_1.time_ <= 1.96599999815226 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_18.localPosition
			end

			local var_68_19 = 0.001

			if 1.96599999815226 <= arg_65_1.time_ and arg_65_1.time_ < 1.96599999815226 + var_68_19 then
				var_68_18.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 1.96599999815226) / var_68_19)
				var_68_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_18.position).x, (manager.ui.mainCamera.transform.position - var_68_18.position).y, (manager.ui.mainCamera.transform.position - var_68_18.position).z)
				var_68_18.localEulerAngles.z = 0
				var_68_18.localEulerAngles.x = 0
				var_68_18.localEulerAngles = var_68_18.localEulerAngles
			end

			if arg_65_1.time_ >= 1.96599999815226 + var_68_19 and arg_65_1.time_ < 1.96599999815226 + var_68_19 + arg_68_0 then
				var_68_18.localPosition = Vector3.New(0, 100, 0)
				var_68_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_18.position).x, (manager.ui.mainCamera.transform.position - var_68_18.position).y, (manager.ui.mainCamera.transform.position - var_68_18.position).z)
				var_68_18.localEulerAngles.z = 0
				var_68_18.localEulerAngles.x = 0
				var_68_18.localEulerAngles = var_68_18.localEulerAngles
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_20 = 4
			local var_68_21 = 0.1

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_22 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_22:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_23 = arg_65_1:GetWordFromCfg(319941016)
				local var_68_24 = arg_65_1:FormatText(var_68_23.content)

				arg_65_1.text_.text = var_68_24

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 4 <= 0 and var_68_21 or var_68_21 * (utf8.len(var_68_24) / 4)

				if (4 <= 0 and var_68_21 or var_68_21 * (utf8.len(var_68_24) / 4)) > 0 and var_68_21 < var_68_26 then
					arg_65_1.talkMaxDuration = var_68_26
					var_68_20 = var_68_20 + 0.3

					if var_68_26 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_26 + var_68_20
					end
				end

				arg_65_1.text_.text = var_68_24
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941016", "story_v_out_319941.awb") ~= 0 then
					local var_68_27 = manager.audio:GetVoiceLength("story_v_out_319941", "319941016", "story_v_out_319941.awb") / 1000

					if var_68_27 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_27 + var_68_20
					end

					if var_68_23.prefab_name ~= "" and arg_65_1.actors_[var_68_23.prefab_name] ~= nil then
						local var_68_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_23.prefab_name].transform, "story_v_out_319941", "319941016", "story_v_out_319941.awb")

						arg_65_1:RecordAudio("319941016", var_68_28)
						arg_65_1:RecordAudio("319941016", var_68_28)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319941", "319941016", "story_v_out_319941.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319941", "319941016", "story_v_out_319941.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_29 = var_68_20 + 0.3
			local var_68_30 = math.max(var_68_21, arg_65_1.talkMaxDuration)

			if var_68_20 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_29 + var_68_30 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_29) / var_68_30

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_29 + var_68_30 and arg_65_1.time_ < var_68_29 + var_68_30 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play319941017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319941017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319941018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = arg_71_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) then
				if arg_71_1.var_.characterEffect1084ui_story and not isNil(arg_71_1.actors_["1084ui_story"]) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.625

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(319941017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 25 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 25)

				if (25 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 25)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319941018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319941018
		arg_75_1.duration_ = 1.63

		local var_75_0 = {
			zh = 1.633,
			ja = 1.4
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
				arg_75_0:Play319941019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = arg_75_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) then
				if arg_75_1.var_.characterEffect1084ui_story and not isNil(arg_75_1.actors_["1084ui_story"]) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_78_2 = 0
			local var_78_3 = 0.075

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:GetWordFromCfg(319941018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 3 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 3)

				if (3 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 3)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941018", "story_v_out_319941.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941018", "story_v_out_319941.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_319941", "319941018", "story_v_out_319941.awb")

						arg_75_1:RecordAudio("319941018", var_78_9)
						arg_75_1:RecordAudio("319941018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319941", "319941018", "story_v_out_319941.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319941", "319941018", "story_v_out_319941.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319941019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319941019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319941020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1084ui_story"]) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = arg_79_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1084ui_story"]) then
				if arg_79_1.var_.characterEffect1084ui_story and not isNil(arg_79_1.actors_["1084ui_story"]) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1084ui_story"]) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.8

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(319941019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 32 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 32)

				if (32 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 32)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319941020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319941020
		arg_83_1.duration_ = 3.43

		local var_83_0 = {
			zh = 3.366,
			ja = 3.433
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
				arg_83_0:Play319941021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = arg_83_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(arg_83_1.actors_["1084ui_story"]) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_86_2 = 0
			local var_86_3 = 0.25

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(319941020)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 10 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 10)

				if (10 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 10)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941020", "story_v_out_319941.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941020", "story_v_out_319941.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_319941", "319941020", "story_v_out_319941.awb")

						arg_83_1:RecordAudio("319941020", var_86_9)
						arg_83_1:RecordAudio("319941020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319941", "319941020", "story_v_out_319941.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319941", "319941020", "story_v_out_319941.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319941021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319941021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319941022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.65

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(319941021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 26 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 26)

				if (26 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 26)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play319941022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319941022
		arg_91_1.duration_ = 2.87

		local var_91_0 = {
			zh = 1.333,
			ja = 2.866
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319941023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1084ui_story"]) and arg_91_1.var_.characterEffect1084ui_story == nil then
				arg_91_1.var_.characterEffect1084ui_story = arg_91_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1084ui_story"]) then
				if arg_91_1.var_.characterEffect1084ui_story and not isNil(arg_91_1.actors_["1084ui_story"]) then
					arg_91_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1084ui_story"]) and arg_91_1.var_.characterEffect1084ui_story then
				arg_91_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_94_2 = 0
			local var_94_3 = 0.15

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(319941022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 6 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 6)

				if (6 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 6)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941022", "story_v_out_319941.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941022", "story_v_out_319941.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_319941", "319941022", "story_v_out_319941.awb")

						arg_91_1:RecordAudio("319941022", var_94_9)
						arg_91_1:RecordAudio("319941022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_319941", "319941022", "story_v_out_319941.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_319941", "319941022", "story_v_out_319941.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319941023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319941023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319941024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1084ui_story"]) and arg_95_1.var_.characterEffect1084ui_story == nil then
				arg_95_1.var_.characterEffect1084ui_story = arg_95_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1084ui_story"]) then
				if arg_95_1.var_.characterEffect1084ui_story and not isNil(arg_95_1.actors_["1084ui_story"]) then
					arg_95_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1084ui_story"]) and arg_95_1.var_.characterEffect1084ui_story then
				arg_95_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(319941023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)

				if (19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319941024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319941024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319941025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.025

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(319941024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 41 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 41)

				if (41 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 41)) > 0 and var_102_0 < var_102_3 then
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
	Play319941025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319941025
		arg_103_1.duration_ = 4.13

		local var_103_0 = {
			zh = 2.4,
			ja = 4.133
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
				arg_103_0:Play319941026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1084ui_story = arg_103_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).z)
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles = arg_103_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_103_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1084ui_story"].transform.position).z)
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1084ui_story"].transform.localEulerAngles = arg_103_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1084ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_106_4 = "10079ui_story"

			if arg_103_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_106_5 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_103_1.stage_.transform)

				var_106_5.name = var_106_4
				var_106_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_4] = var_106_5

				local var_106_6 = var_106_5:GetComponentInChildren(typeof(CharacterEffect))

				var_106_6.enabled = true

				local var_106_7 = GameObjectTools.GetOrAddComponent(var_106_5, typeof(DynamicBoneHelper))

				if var_106_7 then
					var_106_7:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_6.transform, false)

				arg_103_1.var_[var_106_4 .. "Animator"] = var_106_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_4 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_4 .. "LipSync"] = var_106_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_106_8 = 0
			local var_106_9 = 0.2

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(319941025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 8 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 8)

				if (8 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 8)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941025", "story_v_out_319941.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941025", "story_v_out_319941.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_319941", "319941025", "story_v_out_319941.awb")

						arg_103_1:RecordAudio("319941025", var_106_15)
						arg_103_1:RecordAudio("319941025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_319941", "319941025", "story_v_out_319941.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_319941", "319941025", "story_v_out_319941.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_16 and arg_103_1.time_ < var_106_8 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play319941026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319941026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319941027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = arg_107_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) then
				if arg_107_1.var_.characterEffect1084ui_story and not isNil(arg_107_1.actors_["1084ui_story"]) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = false

				arg_107_1:SetGaussion(false)
			end

			local var_110_2 = 0.6

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = Color.New(1, 1, 1)

				var_110_3.a = Mathf.Lerp(1, 0, (arg_107_1.time_ - var_110_1) / var_110_2)
				arg_107_1.mask_.color = var_110_3
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				local var_110_4 = Color.New(1, 1, 1)

				arg_107_1.mask_.enabled = false
				var_110_4.a = 0
				arg_107_1.mask_.color = var_110_4
			end

			local var_110_5 = arg_107_1.actors_["10079ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10079ui_story = var_110_5.localPosition
			end

			local var_110_6 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_107_1.time_ - 0) / var_110_6)
				var_110_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_5.position).x, (manager.ui.mainCamera.transform.position - var_110_5.position).y, (manager.ui.mainCamera.transform.position - var_110_5.position).z)
				var_110_5.localEulerAngles.z = 0
				var_110_5.localEulerAngles.x = 0
				var_110_5.localEulerAngles = var_110_5.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(0, -0.95, -6.05)
				var_110_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_5.position).x, (manager.ui.mainCamera.transform.position - var_110_5.position).y, (manager.ui.mainCamera.transform.position - var_110_5.position).z)
				var_110_5.localEulerAngles.z = 0
				var_110_5.localEulerAngles.x = 0
				var_110_5.localEulerAngles = var_110_5.localEulerAngles
			end

			local var_110_7 = arg_107_1.actors_["10079ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = var_110_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_8 = 0.034000001847744

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_8 and not isNil(var_110_7) then
				if arg_107_1.var_.characterEffect10079ui_story and not isNil(var_110_7) then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_8)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_8 and arg_107_1.time_ < 0 + var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_110_9 = arg_107_1.actors_["1084ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1084ui_story = var_110_9.localPosition
			end

			local var_110_10 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_10 then
				var_110_9.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_10)
				var_110_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_9.position).x, (manager.ui.mainCamera.transform.position - var_110_9.position).y, (manager.ui.mainCamera.transform.position - var_110_9.position).z)
				var_110_9.localEulerAngles.z = 0
				var_110_9.localEulerAngles.x = 0
				var_110_9.localEulerAngles = var_110_9.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_10 and arg_107_1.time_ < 0 + var_110_10 + arg_110_0 then
				var_110_9.localPosition = Vector3.New(0, 100, 0)
				var_110_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_9.position).x, (manager.ui.mainCamera.transform.position - var_110_9.position).y, (manager.ui.mainCamera.transform.position - var_110_9.position).z)
				var_110_9.localEulerAngles.z = 0
				var_110_9.localEulerAngles.x = 0
				var_110_9.localEulerAngles = var_110_9.localEulerAngles
			end

			local var_110_11 = 0
			local var_110_12 = 1.2

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319941026).content)

				arg_107_1.text_.text = var_110_13

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 48 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_13) / 48)

				if (48 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_13) / 48)) > 0 and var_110_12 < var_110_15 then
					arg_107_1.talkMaxDuration = var_110_15

					if var_110_15 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_15 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_13
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_16 and arg_107_1.time_ < var_110_11 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_107_1:InitPlayNodeList()
	end,
	Play319941027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319941027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319941028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.4

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

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(319941027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 56 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 56)

				if (56 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 56)) > 0 and var_114_0 < var_114_3 then
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
	Play319941028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319941028
		arg_115_1.duration_ = 5.13

		local var_115_0 = {
			zh = 4.9,
			ja = 5.133
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
				arg_115_0:Play319941029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10079ui_story = arg_115_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).z)
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles = arg_115_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_115_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10079ui_story"].transform.position).z)
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10079ui_story"].transform.localEulerAngles = arg_115_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["10079ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10079ui_story == nil then
				arg_115_1.var_.characterEffect10079ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect10079ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10079ui_story then
				arg_115_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.525

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(319941028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 21 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 21)

				if (21 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 21)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941028", "story_v_out_319941.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941028", "story_v_out_319941.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_319941", "319941028", "story_v_out_319941.awb")

						arg_115_1:RecordAudio("319941028", var_118_11)
						arg_115_1:RecordAudio("319941028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319941", "319941028", "story_v_out_319941.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319941", "319941028", "story_v_out_319941.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319941029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319941029
		arg_119_1.duration_ = 9.93

		local var_119_0 = {
			zh = 9.933,
			ja = 5.333
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
				arg_119_0:Play319941030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_122_0 = 0
			local var_122_1 = 0.975

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(319941029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 39 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 39)

				if (39 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 39)) > 0 and var_122_1 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941029", "story_v_out_319941.awb") ~= 0 then
					local var_122_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941029", "story_v_out_319941.awb") / 1000

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end

					if var_122_2.prefab_name ~= "" and arg_119_1.actors_[var_122_2.prefab_name] ~= nil then
						local var_122_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_2.prefab_name].transform, "story_v_out_319941", "319941029", "story_v_out_319941.awb")

						arg_119_1:RecordAudio("319941029", var_122_7)
						arg_119_1:RecordAudio("319941029", var_122_7)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319941", "319941029", "story_v_out_319941.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319941", "319941029", "story_v_out_319941.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319941030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319941030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319941031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10079ui_story = arg_123_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).z)
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles = arg_123_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10079ui_story"].transform.position).z)
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10079ui_story"].transform.localEulerAngles = arg_123_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_126_1 = 0
			local var_126_2 = 1.325

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(319941030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 53 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 53)

				if (53 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 53)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play319941031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319941031
		arg_127_1.duration_ = 14.4

		local var_127_0 = {
			zh = 9.366,
			ja = 14.4
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
				arg_127_0:Play319941032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.ST74 == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_130_0.name = "ST74"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.ST74 = var_130_0
			end

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= 2 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.ST74

				arg_127_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST74" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 3.999999999999

			if 3.999999999999 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_4 + 0.3 and arg_127_1.time_ < var_130_4 + 0.3 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_5 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 2

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				var_130_8.a = 1
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = 2

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_10 = 2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				local var_130_11 = Color.New(0, 0, 0)

				var_130_11.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_9) / var_130_10)
				arg_127_1.mask_.color = var_130_11
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				local var_130_12 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_12.a = 0
				arg_127_1.mask_.color = var_130_12
			end

			local var_130_13 = "1095ui_story"

			if arg_127_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_130_14 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_127_1.stage_.transform)

				var_130_14.name = var_130_13
				var_130_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_[var_130_13] = var_130_14

				local var_130_15 = var_130_14:GetComponentInChildren(typeof(CharacterEffect))

				var_130_15.enabled = true

				local var_130_16 = GameObjectTools.GetOrAddComponent(var_130_14, typeof(DynamicBoneHelper))

				if var_130_16 then
					var_130_16:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_15.transform, false)

				arg_127_1.var_[var_130_13 .. "Animator"] = var_130_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_[var_130_13 .. "Animator"].applyRootMotion = true
				arg_127_1.var_[var_130_13 .. "LipSync"] = var_130_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_17 = arg_127_1.actors_["1095ui_story"].transform

			if 3.8 < arg_127_1.time_ and arg_127_1.time_ <= 3.8 + arg_130_0 then
				arg_127_1.var_.moveOldPos1095ui_story = var_130_17.localPosition
			end

			local var_130_18 = 0.001

			if 3.8 <= arg_127_1.time_ and arg_127_1.time_ < 3.8 + var_130_18 then
				var_130_17.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_127_1.time_ - 3.8) / var_130_18)
				var_130_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_17.position).x, (manager.ui.mainCamera.transform.position - var_130_17.position).y, (manager.ui.mainCamera.transform.position - var_130_17.position).z)
				var_130_17.localEulerAngles.z = 0
				var_130_17.localEulerAngles.x = 0
				var_130_17.localEulerAngles = var_130_17.localEulerAngles
			end

			if arg_127_1.time_ >= 3.8 + var_130_18 and arg_127_1.time_ < 3.8 + var_130_18 + arg_130_0 then
				var_130_17.localPosition = Vector3.New(0, -0.98, -6.1)
				var_130_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_17.position).x, (manager.ui.mainCamera.transform.position - var_130_17.position).y, (manager.ui.mainCamera.transform.position - var_130_17.position).z)
				var_130_17.localEulerAngles.z = 0
				var_130_17.localEulerAngles.x = 0
				var_130_17.localEulerAngles = var_130_17.localEulerAngles
			end

			local var_130_19 = arg_127_1.actors_["1095ui_story"]

			if 3.8 < arg_127_1.time_ and arg_127_1.time_ <= 3.8 + arg_130_0 and not isNil(var_130_19) and arg_127_1.var_.characterEffect1095ui_story == nil then
				arg_127_1.var_.characterEffect1095ui_story = var_130_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_20 = 0.200000002980232

			if 3.8 <= arg_127_1.time_ and arg_127_1.time_ < 3.8 + var_130_20 and not isNil(var_130_19) then
				if arg_127_1.var_.characterEffect1095ui_story and not isNil(var_130_19) then
					arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 3.8 + var_130_20 and arg_127_1.time_ < 3.8 + var_130_20 + arg_130_0 and not isNil(var_130_19) and arg_127_1.var_.characterEffect1095ui_story then
				arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 3.8 < arg_127_1.time_ and arg_127_1.time_ <= 3.8 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.8 < arg_127_1.time_ and arg_127_1.time_ <= 3.8 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_22 = arg_127_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_127_1.time_ and arg_127_1.time_ <= 1.96599999815226 + arg_130_0 then
				arg_127_1.var_.moveOldPos1084ui_story = var_130_22.localPosition
			end

			local var_130_23 = 0.001

			if 1.96599999815226 <= arg_127_1.time_ and arg_127_1.time_ < 1.96599999815226 + var_130_23 then
				var_130_22.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 1.96599999815226) / var_130_23)
				var_130_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_22.position).x, (manager.ui.mainCamera.transform.position - var_130_22.position).y, (manager.ui.mainCamera.transform.position - var_130_22.position).z)
				var_130_22.localEulerAngles.z = 0
				var_130_22.localEulerAngles.x = 0
				var_130_22.localEulerAngles = var_130_22.localEulerAngles
			end

			if arg_127_1.time_ >= 1.96599999815226 + var_130_23 and arg_127_1.time_ < 1.96599999815226 + var_130_23 + arg_130_0 then
				var_130_22.localPosition = Vector3.New(0, 100, 0)
				var_130_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_22.position).x, (manager.ui.mainCamera.transform.position - var_130_22.position).y, (manager.ui.mainCamera.transform.position - var_130_22.position).z)
				var_130_22.localEulerAngles.z = 0
				var_130_22.localEulerAngles.x = 0
				var_130_22.localEulerAngles = var_130_22.localEulerAngles
			end

			local var_130_24 = arg_127_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_127_1.time_ and arg_127_1.time_ <= 1.96599999815226 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_25 = 0.034000001847744

			if 1.96599999815226 <= arg_127_1.time_ and arg_127_1.time_ < 1.96599999815226 + var_130_25 and not isNil(var_130_24) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_24) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 1.96599999815226) / var_130_25)
				end
			end

			if arg_127_1.time_ >= 1.96599999815226 + var_130_25 and arg_127_1.time_ < 1.96599999815226 + var_130_25 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_26 = 4
			local var_130_27 = 0.725

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_26 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_28 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_28:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_29 = arg_127_1:GetWordFromCfg(319941031)
				local var_130_30 = arg_127_1:FormatText(var_130_29.content)

				arg_127_1.text_.text = var_130_30

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_32 = 29 <= 0 and var_130_27 or var_130_27 * (utf8.len(var_130_30) / 29)

				if (29 <= 0 and var_130_27 or var_130_27 * (utf8.len(var_130_30) / 29)) > 0 and var_130_27 < var_130_32 then
					arg_127_1.talkMaxDuration = var_130_32
					var_130_26 = var_130_26 + 0.3

					if var_130_32 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_32 + var_130_26
					end
				end

				arg_127_1.text_.text = var_130_30
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941031", "story_v_out_319941.awb") ~= 0 then
					local var_130_33 = manager.audio:GetVoiceLength("story_v_out_319941", "319941031", "story_v_out_319941.awb") / 1000

					if var_130_33 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_33 + var_130_26
					end

					if var_130_29.prefab_name ~= "" and arg_127_1.actors_[var_130_29.prefab_name] ~= nil then
						local var_130_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_29.prefab_name].transform, "story_v_out_319941", "319941031", "story_v_out_319941.awb")

						arg_127_1:RecordAudio("319941031", var_130_34)
						arg_127_1:RecordAudio("319941031", var_130_34)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319941", "319941031", "story_v_out_319941.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319941", "319941031", "story_v_out_319941.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_35 = var_130_26 + 0.3
			local var_130_36 = math.max(var_130_27, arg_127_1.talkMaxDuration)

			if var_130_26 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_35 + var_130_36 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_35) / var_130_36

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_35 + var_130_36 and arg_127_1.time_ < var_130_35 + var_130_36 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play319941032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319941032
		arg_133_1.duration_ = 8.63

		local var_133_0 = {
			zh = 6.833,
			ja = 8.633
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
				arg_133_0:Play319941033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(319941032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 39 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 39)

				if (39 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 39)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941032", "story_v_out_319941.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941032", "story_v_out_319941.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_319941", "319941032", "story_v_out_319941.awb")

						arg_133_1:RecordAudio("319941032", var_136_6)
						arg_133_1:RecordAudio("319941032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319941", "319941032", "story_v_out_319941.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319941", "319941032", "story_v_out_319941.awb")
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
	Play319941033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319941033
		arg_137_1.duration_ = 6.97

		local var_137_0 = {
			zh = 6.466,
			ja = 6.966
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
				arg_137_0:Play319941034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.8

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(319941033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 32 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 32)

				if (32 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 32)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941033", "story_v_out_319941.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941033", "story_v_out_319941.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_319941", "319941033", "story_v_out_319941.awb")

						arg_137_1:RecordAudio("319941033", var_140_6)
						arg_137_1:RecordAudio("319941033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319941", "319941033", "story_v_out_319941.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319941", "319941033", "story_v_out_319941.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319941034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319941034
		arg_141_1.duration_ = 7.73

		local var_141_0 = {
			zh = 5.233,
			ja = 7.733
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
				arg_141_0:Play319941035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1095ui_story = arg_141_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1095ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story then
				arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0.65 < arg_141_1.time_ and arg_141_1.time_ <= 0.65 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0.65 < arg_141_1.time_ and arg_141_1.time_ <= 0.65 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.65

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(319941034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)

				if (26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941034", "story_v_out_319941.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941034", "story_v_out_319941.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_319941", "319941034", "story_v_out_319941.awb")

						arg_141_1:RecordAudio("319941034", var_144_11)
						arg_141_1:RecordAudio("319941034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319941", "319941034", "story_v_out_319941.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319941", "319941034", "story_v_out_319941.awb")
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
				actorName = "1095ui_story",
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
	Play319941035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319941035
		arg_145_1.duration_ = 5.6

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play319941036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = arg_145_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(arg_145_1.actors_["1095ui_story"]) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_148_1 = arg_145_1.actors_["1095ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = manager.ui.mainCamera.transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.shakeOldPos = var_148_3.localPosition
			end

			local var_148_4 = 0.6

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				local var_148_5, var_148_6 = math.modf((arg_145_1.time_ - 0) / 0.066)

				var_148_3.localPosition = Vector3.New(var_148_6 * 0.13, var_148_6 * 0.13, var_148_6 * 0.13) + arg_145_1.var_.shakeOldPos
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = arg_145_1.var_.shakeOldPos
			end

			local var_148_7 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_7 + 0.6 and arg_145_1.time_ < var_148_7 + 0.6 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_8 = 0.6
			local var_148_9 = 1.375

			if 0.6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_10 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_10:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(319941035).content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 55 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 55)

				if (55 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 55)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13
					var_148_8 = var_148_8 + 0.3

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = var_148_8 + 0.3
			local var_148_15 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_15 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_15

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_15 and arg_145_1.time_ < var_148_14 + var_148_15 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319941036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319941036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319941037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.5

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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(319941036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 20 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 20)

				if (20 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 20)) > 0 and var_154_0 < var_154_3 then
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
	Play319941037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319941037
		arg_155_1.duration_ = 7

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319941038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 1 < arg_155_1.time_ and arg_155_1.time_ <= 1 + arg_158_0 then
				local var_158_0 = arg_155_1.bgs_.D02a

				arg_155_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_1 = var_158_0:GetComponent("SpriteRenderer")

				if var_158_1 and var_158_1.sprite then
					local var_158_2 = 2 * (var_158_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_0.transform.localScale = Vector3.New(var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "D02a" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_3 = 2

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			if arg_155_1.time_ >= var_158_3 + 0.3 and arg_155_1.time_ < var_158_3 + 0.3 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			local var_158_4 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_5 = 1

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_5 then
				local var_158_6 = Color.New(0, 0, 0)

				var_158_6.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_4) / var_158_5)
				arg_155_1.mask_.color = var_158_6
			end

			if arg_155_1.time_ >= var_158_4 + var_158_5 and arg_155_1.time_ < var_158_4 + var_158_5 + arg_158_0 then
				local var_158_7 = Color.New(0, 0, 0)

				var_158_7.a = 1
				arg_155_1.mask_.color = var_158_7
			end

			local var_158_8 = 1

			if 1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_9 = 1

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 then
				local var_158_10 = Color.New(0, 0, 0)

				var_158_10.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_8) / var_158_9)
				arg_155_1.mask_.color = var_158_10
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 then
				local var_158_11 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_11.a = 0
				arg_155_1.mask_.color = var_158_11
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_12 = 2
			local var_158_13 = 1

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_14 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_14:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(319941037).content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 40 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 40)

				if (40 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 40)) > 0 and var_158_13 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17
					var_158_12 = var_158_12 + 0.3

					if var_158_17 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_18 = var_158_12 + 0.3
			local var_158_19 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_18 + var_158_19 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_18) / var_158_19

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_18 + var_158_19 and arg_155_1.time_ < var_158_18 + var_158_19 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319941038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319941038
		arg_161_1.duration_ = 2.4

		local var_161_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_161_0:Play319941039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1095ui_story = arg_161_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).z)
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles = arg_161_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_161_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1095ui_story"].transform.position).z)
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1095ui_story"].transform.localEulerAngles = arg_161_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1095ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1095ui_story == nil then
				arg_161_1.var_.characterEffect1095ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1095ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1095ui_story then
				arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.125

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(319941038)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 5 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 5)

				if (5 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 5)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941038", "story_v_out_319941.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941038", "story_v_out_319941.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_319941", "319941038", "story_v_out_319941.awb")

						arg_161_1:RecordAudio("319941038", var_164_11)
						arg_161_1:RecordAudio("319941038", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319941", "319941038", "story_v_out_319941.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319941", "319941038", "story_v_out_319941.awb")
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
				actorName = "1095ui_story",
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
	Play319941039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319941039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319941040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = arg_165_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(arg_165_1.actors_["1095ui_story"]) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1095ui_story"]) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.775

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

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(319941039).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 31 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 31)

				if (31 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 31)) > 0 and var_168_2 < var_168_5 then
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
	Play319941040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319941040
		arg_169_1.duration_ = 1.9

		local var_169_0 = {
			zh = 1.9,
			ja = 1.1
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
				arg_169_0:Play319941041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = arg_169_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) then
				if arg_169_1.var_.characterEffect1095ui_story and not isNil(arg_169_1.actors_["1095ui_story"]) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1095ui_story"]) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_172_2 = 0
			local var_172_3 = 0.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(319941040)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 6 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 6)

				if (6 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 6)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941040", "story_v_out_319941.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941040", "story_v_out_319941.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_319941", "319941040", "story_v_out_319941.awb")

						arg_169_1:RecordAudio("319941040", var_172_9)
						arg_169_1:RecordAudio("319941040", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319941", "319941040", "story_v_out_319941.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319941", "319941040", "story_v_out_319941.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319941041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319941041
		arg_173_1.duration_ = 6.57

		local var_173_0 = {
			zh = 5.666,
			ja = 6.566
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
				arg_173_0:Play319941042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1084ui_story = arg_173_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).z)
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles = arg_173_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_173_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1084ui_story"].transform.position).z)
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1084ui_story"].transform.localEulerAngles = arg_173_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1084ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1084ui_story == nil then
				arg_173_1.var_.characterEffect1084ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1084ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1084ui_story then
				arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_176_4 = arg_173_1.actors_["1095ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1095ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			local var_176_6 = arg_173_1.actors_["1095ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_176_8 = 0
			local var_176_9 = 0.55

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
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

				local var_176_10 = arg_173_1:GetWordFromCfg(319941041)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 22 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 22)

				if (22 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 22)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941041", "story_v_out_319941.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941041", "story_v_out_319941.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_319941", "319941041", "story_v_out_319941.awb")

						arg_173_1:RecordAudio("319941041", var_176_15)
						arg_173_1:RecordAudio("319941041", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319941", "319941041", "story_v_out_319941.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319941", "319941041", "story_v_out_319941.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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
	Play319941042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319941042
		arg_177_1.duration_ = 11.6

		local var_177_0 = {
			zh = 8.766,
			ja = 11.6
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
				arg_177_0:Play319941043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if arg_177_1.bgs_.I11l == nil then
				local var_180_0 = Object.Instantiate(arg_177_1.paintGo_)

				var_180_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11l")
				var_180_0.name = "I11l"
				var_180_0.transform.parent = arg_177_1.stage_.transform
				var_180_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.bgs_.I11l = var_180_0
			end

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= 2 + arg_180_0 then
				local var_180_1 = arg_177_1.bgs_.I11l

				arg_177_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_2 = var_180_1:GetComponent("SpriteRenderer")

				if var_180_2 and var_180_2.sprite then
					local var_180_3 = 2 * (var_180_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_1.transform.localScale = Vector3.New(var_180_3 / var_180_2.sprite.bounds.size.y < var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x and var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x or var_180_3 / var_180_2.sprite.bounds.size.y, var_180_3 / var_180_2.sprite.bounds.size.y < var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x and var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x or var_180_3 / var_180_2.sprite.bounds.size.y, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "I11l" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_4 = 4

			if 4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_4 + 0.3 and arg_177_1.time_ < var_180_4 + 0.3 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_5 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_6 = 2

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 then
				local var_180_7 = Color.New(0, 0, 0)

				var_180_7.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - var_180_5) / var_180_6)
				arg_177_1.mask_.color = var_180_7
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 then
				local var_180_8 = Color.New(0, 0, 0)

				var_180_8.a = 1
				arg_177_1.mask_.color = var_180_8
			end

			local var_180_9 = 2

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_10 = 2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 then
				local var_180_11 = Color.New(0, 0, 0)

				var_180_11.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_9) / var_180_10)
				arg_177_1.mask_.color = var_180_11
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 then
				local var_180_12 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_12.a = 0
				arg_177_1.mask_.color = var_180_12
			end

			local var_180_13 = arg_177_1.actors_["1095ui_story"].transform

			if 1.966 < arg_177_1.time_ and arg_177_1.time_ <= 1.966 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_13.localPosition
			end

			local var_180_14 = 0.001

			if 1.966 <= arg_177_1.time_ and arg_177_1.time_ < 1.966 + var_180_14 then
				var_180_13.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 1.966) / var_180_14)
				var_180_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_13.position).x, (manager.ui.mainCamera.transform.position - var_180_13.position).y, (manager.ui.mainCamera.transform.position - var_180_13.position).z)
				var_180_13.localEulerAngles.z = 0
				var_180_13.localEulerAngles.x = 0
				var_180_13.localEulerAngles = var_180_13.localEulerAngles
			end

			if arg_177_1.time_ >= 1.966 + var_180_14 and arg_177_1.time_ < 1.966 + var_180_14 + arg_180_0 then
				var_180_13.localPosition = Vector3.New(0, 100, 0)
				var_180_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_13.position).x, (manager.ui.mainCamera.transform.position - var_180_13.position).y, (manager.ui.mainCamera.transform.position - var_180_13.position).z)
				var_180_13.localEulerAngles.z = 0
				var_180_13.localEulerAngles.x = 0
				var_180_13.localEulerAngles = var_180_13.localEulerAngles
			end

			local var_180_15 = arg_177_1.actors_["1084ui_story"].transform

			if 1.966 < arg_177_1.time_ and arg_177_1.time_ <= 1.966 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = var_180_15.localPosition
			end

			local var_180_16 = 0.001

			if 1.966 <= arg_177_1.time_ and arg_177_1.time_ < 1.966 + var_180_16 then
				var_180_15.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 1.966) / var_180_16)
				var_180_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_15.position).x, (manager.ui.mainCamera.transform.position - var_180_15.position).y, (manager.ui.mainCamera.transform.position - var_180_15.position).z)
				var_180_15.localEulerAngles.z = 0
				var_180_15.localEulerAngles.x = 0
				var_180_15.localEulerAngles = var_180_15.localEulerAngles
			end

			if arg_177_1.time_ >= 1.966 + var_180_16 and arg_177_1.time_ < 1.966 + var_180_16 + arg_180_0 then
				var_180_15.localPosition = Vector3.New(0, 100, 0)
				var_180_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_15.position).x, (manager.ui.mainCamera.transform.position - var_180_15.position).y, (manager.ui.mainCamera.transform.position - var_180_15.position).z)
				var_180_15.localEulerAngles.z = 0
				var_180_15.localEulerAngles.x = 0
				var_180_15.localEulerAngles = var_180_15.localEulerAngles
			end

			local var_180_17 = arg_177_1.actors_["1084ui_story"].transform

			if 3.8 < arg_177_1.time_ and arg_177_1.time_ <= 3.8 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = var_180_17.localPosition
			end

			local var_180_18 = 0.001

			if 3.8 <= arg_177_1.time_ and arg_177_1.time_ < 3.8 + var_180_18 then
				var_180_17.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_177_1.time_ - 3.8) / var_180_18)
				var_180_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_17.position).x, (manager.ui.mainCamera.transform.position - var_180_17.position).y, (manager.ui.mainCamera.transform.position - var_180_17.position).z)
				var_180_17.localEulerAngles.z = 0
				var_180_17.localEulerAngles.x = 0
				var_180_17.localEulerAngles = var_180_17.localEulerAngles
			end

			if arg_177_1.time_ >= 3.8 + var_180_18 and arg_177_1.time_ < 3.8 + var_180_18 + arg_180_0 then
				var_180_17.localPosition = Vector3.New(0, -0.97, -6)
				var_180_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_17.position).x, (manager.ui.mainCamera.transform.position - var_180_17.position).y, (manager.ui.mainCamera.transform.position - var_180_17.position).z)
				var_180_17.localEulerAngles.z = 0
				var_180_17.localEulerAngles.x = 0
				var_180_17.localEulerAngles = var_180_17.localEulerAngles
			end

			local var_180_19 = arg_177_1.actors_["1095ui_story"].transform

			if 3.8 < arg_177_1.time_ and arg_177_1.time_ <= 3.8 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_19.localPosition
			end

			local var_180_20 = 0.001

			if 3.8 <= arg_177_1.time_ and arg_177_1.time_ < 3.8 + var_180_20 then
				var_180_19.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 3.8) / var_180_20)
				var_180_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_19.position).x, (manager.ui.mainCamera.transform.position - var_180_19.position).y, (manager.ui.mainCamera.transform.position - var_180_19.position).z)
				var_180_19.localEulerAngles.z = 0
				var_180_19.localEulerAngles.x = 0
				var_180_19.localEulerAngles = var_180_19.localEulerAngles
			end

			if arg_177_1.time_ >= 3.8 + var_180_20 and arg_177_1.time_ < 3.8 + var_180_20 + arg_180_0 then
				var_180_19.localPosition = Vector3.New(0, 100, 0)
				var_180_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_19.position).x, (manager.ui.mainCamera.transform.position - var_180_19.position).y, (manager.ui.mainCamera.transform.position - var_180_19.position).z)
				var_180_19.localEulerAngles.z = 0
				var_180_19.localEulerAngles.x = 0
				var_180_19.localEulerAngles = var_180_19.localEulerAngles
			end

			if 3.8 < arg_177_1.time_ and arg_177_1.time_ <= 3.8 + arg_180_0 then
				arg_177_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.8 < arg_177_1.time_ and arg_177_1.time_ <= 3.8 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_180_21 = arg_177_1.actors_["1084ui_story"]

			if 3.8 < arg_177_1.time_ and arg_177_1.time_ <= 3.8 + arg_180_0 and not isNil(var_180_21) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_22 = 0.2

			if 3.8 <= arg_177_1.time_ and arg_177_1.time_ < 3.8 + var_180_22 and not isNil(var_180_21) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_21) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 3.8 + var_180_22 and arg_177_1.time_ < 3.8 + var_180_22 + arg_180_0 and not isNil(var_180_21) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_24 = 4
			local var_180_25 = 0.725

			if 4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_24 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_26 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_26:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_27 = arg_177_1:GetWordFromCfg(319941042)
				local var_180_28 = arg_177_1:FormatText(var_180_27.content)

				arg_177_1.text_.text = var_180_28

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_30 = 29 <= 0 and var_180_25 or var_180_25 * (utf8.len(var_180_28) / 29)

				if (29 <= 0 and var_180_25 or var_180_25 * (utf8.len(var_180_28) / 29)) > 0 and var_180_25 < var_180_30 then
					arg_177_1.talkMaxDuration = var_180_30
					var_180_24 = var_180_24 + 0.3

					if var_180_30 + var_180_24 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_24
					end
				end

				arg_177_1.text_.text = var_180_28
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941042", "story_v_out_319941.awb") ~= 0 then
					local var_180_31 = manager.audio:GetVoiceLength("story_v_out_319941", "319941042", "story_v_out_319941.awb") / 1000

					if var_180_31 + var_180_24 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_24
					end

					if var_180_27.prefab_name ~= "" and arg_177_1.actors_[var_180_27.prefab_name] ~= nil then
						local var_180_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_27.prefab_name].transform, "story_v_out_319941", "319941042", "story_v_out_319941.awb")

						arg_177_1:RecordAudio("319941042", var_180_32)
						arg_177_1:RecordAudio("319941042", var_180_32)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319941", "319941042", "story_v_out_319941.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319941", "319941042", "story_v_out_319941.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_33 = var_180_24 + 0.3
			local var_180_34 = math.max(var_180_25, arg_177_1.talkMaxDuration)

			if var_180_24 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_33 + var_180_34 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_33) / var_180_34

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_33 + var_180_34 and arg_177_1.time_ < var_180_33 + var_180_34 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play319941043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319941043
		arg_183_1.duration_ = 10.87

		local var_183_0 = {
			zh = 8.766,
			ja = 10.866
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319941044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.175

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(319941043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 47 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 47)

				if (47 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 47)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941043", "story_v_out_319941.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941043", "story_v_out_319941.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_319941", "319941043", "story_v_out_319941.awb")

						arg_183_1:RecordAudio("319941043", var_186_6)
						arg_183_1:RecordAudio("319941043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319941", "319941043", "story_v_out_319941.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319941", "319941043", "story_v_out_319941.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319941044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319941044
		arg_187_1.duration_ = 9.47

		local var_187_0 = {
			zh = 8.9,
			ja = 9.466
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319941045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(319941044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 46 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 46)

				if (46 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 46)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941044", "story_v_out_319941.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941044", "story_v_out_319941.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_319941", "319941044", "story_v_out_319941.awb")

						arg_187_1:RecordAudio("319941044", var_190_6)
						arg_187_1:RecordAudio("319941044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319941", "319941044", "story_v_out_319941.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319941", "319941044", "story_v_out_319941.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319941045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319941045
		arg_191_1.duration_ = 7.93

		local var_191_0 = {
			zh = 7.566,
			ja = 7.933
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319941046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.1

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(319941045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 44 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 44)

				if (44 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 44)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941045", "story_v_out_319941.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941045", "story_v_out_319941.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_319941", "319941045", "story_v_out_319941.awb")

						arg_191_1:RecordAudio("319941045", var_194_6)
						arg_191_1:RecordAudio("319941045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319941", "319941045", "story_v_out_319941.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319941", "319941045", "story_v_out_319941.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319941046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319941046
		arg_195_1.duration_ = 12.33

		local var_195_0 = {
			zh = 6.2,
			ja = 12.333
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319941047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_198_0 = 0
			local var_198_1 = 0.775

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(319941046)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 31 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 31)

				if (31 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 31)) > 0 and var_198_1 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941046", "story_v_out_319941.awb") ~= 0 then
					local var_198_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941046", "story_v_out_319941.awb") / 1000

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end

					if var_198_2.prefab_name ~= "" and arg_195_1.actors_[var_198_2.prefab_name] ~= nil then
						local var_198_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_2.prefab_name].transform, "story_v_out_319941", "319941046", "story_v_out_319941.awb")

						arg_195_1:RecordAudio("319941046", var_198_7)
						arg_195_1:RecordAudio("319941046", var_198_7)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319941", "319941046", "story_v_out_319941.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319941", "319941046", "story_v_out_319941.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319941047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319941047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319941048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = arg_199_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) then
				if arg_199_1.var_.characterEffect1084ui_story and not isNil(arg_199_1.actors_["1084ui_story"]) then
					arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story then
				arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_202_1 = arg_199_1.actors_["1095ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1095ui_story = var_202_1.localPosition
			end

			local var_202_2 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 then
				var_202_1.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_2)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 then
				var_202_1.localPosition = Vector3.New(0, 100, 0)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			local var_202_3 = arg_199_1.actors_["1084ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1084ui_story = var_202_3.localPosition
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_3.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_4)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_3.localPosition = Vector3.New(0, 100, 0)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			local var_202_5 = 0
			local var_202_6 = 0.95

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(319941047).content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 38 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 38)

				if (38 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 38)) > 0 and var_202_6 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_10 and arg_199_1.time_ < var_202_5 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319941048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319941048
		arg_203_1.duration_ = 2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319941049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1095ui_story = arg_203_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).z)
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles = arg_203_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_203_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1095ui_story"].transform.position).z)
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1095ui_story"].transform.localEulerAngles = arg_203_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_206_1 = arg_203_1.actors_["1095ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1095ui_story == nil then
				arg_203_1.var_.characterEffect1095ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1095ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1095ui_story then
				arg_203_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_206_4 = 0
			local var_206_5 = 0.225

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(319941048)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 9 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 9)

				if (9 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 9)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941048", "story_v_out_319941.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941048", "story_v_out_319941.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_319941", "319941048", "story_v_out_319941.awb")

						arg_203_1:RecordAudio("319941048", var_206_11)
						arg_203_1:RecordAudio("319941048", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319941", "319941048", "story_v_out_319941.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319941", "319941048", "story_v_out_319941.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play319941049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319941049
		arg_207_1.duration_ = 7.67

		local var_207_0 = {
			zh = 4.8,
			ja = 7.666
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319941050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1095ui_story = arg_207_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).z)
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles = arg_207_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_207_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1095ui_story"].transform.position).z)
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1095ui_story"].transform.localEulerAngles = arg_207_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1095ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1095ui_story == nil then
				arg_207_1.var_.characterEffect1095ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1095ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1095ui_story then
				arg_207_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_210_3 = arg_207_1.actors_["1084ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_207_1.time_ - 0) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_210_5 = arg_207_1.actors_["1084ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_210_8 = 0
			local var_210_9 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(319941049)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 26 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 26)

				if (26 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 26)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941049", "story_v_out_319941.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941049", "story_v_out_319941.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_319941", "319941049", "story_v_out_319941.awb")

						arg_207_1:RecordAudio("319941049", var_210_15)
						arg_207_1:RecordAudio("319941049", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319941", "319941049", "story_v_out_319941.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319941", "319941049", "story_v_out_319941.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_207_1:InitPlayNodeList()
	end,
	Play319941050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319941050
		arg_211_1.duration_ = 3.9

		local var_211_0 = {
			zh = 2.866,
			ja = 3.9
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319941051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.45

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(319941050)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 18 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 18)

				if (18 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 18)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941050", "story_v_out_319941.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941050", "story_v_out_319941.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_319941", "319941050", "story_v_out_319941.awb")

						arg_211_1:RecordAudio("319941050", var_214_6)
						arg_211_1:RecordAudio("319941050", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319941", "319941050", "story_v_out_319941.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319941", "319941050", "story_v_out_319941.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319941051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319941051
		arg_215_1.duration_ = 6.63

		local var_215_0 = {
			zh = 6.633,
			ja = 3.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319941052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1095ui_story"]) and arg_215_1.var_.characterEffect1095ui_story == nil then
				arg_215_1.var_.characterEffect1095ui_story = arg_215_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1095ui_story"]) then
				if arg_215_1.var_.characterEffect1095ui_story and not isNil(arg_215_1.actors_["1095ui_story"]) then
					arg_215_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1095ui_story"]) and arg_215_1.var_.characterEffect1095ui_story then
				arg_215_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_218_2 = arg_215_1.actors_["1084ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = var_218_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_3 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.characterEffect1084ui_story and not isNil(var_218_2) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_3)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_218_4 = 0
			local var_218_5 = 0.6

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(319941051)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 24 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 24)

				if (24 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 24)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941051", "story_v_out_319941.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941051", "story_v_out_319941.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_319941", "319941051", "story_v_out_319941.awb")

						arg_215_1:RecordAudio("319941051", var_218_11)
						arg_215_1:RecordAudio("319941051", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_319941", "319941051", "story_v_out_319941.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_319941", "319941051", "story_v_out_319941.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319941052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319941052
		arg_219_1.duration_ = 3

		local var_219_0 = {
			zh = 2.766,
			ja = 3
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
				arg_219_0:Play319941053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1095ui_story"]) and arg_219_1.var_.characterEffect1095ui_story == nil then
				arg_219_1.var_.characterEffect1095ui_story = arg_219_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1095ui_story"]) then
				if arg_219_1.var_.characterEffect1095ui_story and not isNil(arg_219_1.actors_["1095ui_story"]) then
					arg_219_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1095ui_story"]) and arg_219_1.var_.characterEffect1095ui_story then
				arg_219_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_222_1 = arg_219_1.actors_["1084ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_4 = 0
			local var_222_5 = 0.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(319941052)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 12 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 12)

				if (12 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 12)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941052", "story_v_out_319941.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941052", "story_v_out_319941.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_319941", "319941052", "story_v_out_319941.awb")

						arg_219_1:RecordAudio("319941052", var_222_11)
						arg_219_1:RecordAudio("319941052", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_319941", "319941052", "story_v_out_319941.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_319941", "319941052", "story_v_out_319941.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319941053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319941053
		arg_223_1.duration_ = 7.07

		local var_223_0 = {
			zh = 7.066,
			ja = 6.766
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
				arg_223_0:Play319941054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1095ui_story"]) and arg_223_1.var_.characterEffect1095ui_story == nil then
				arg_223_1.var_.characterEffect1095ui_story = arg_223_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1095ui_story"]) then
				if arg_223_1.var_.characterEffect1095ui_story and not isNil(arg_223_1.actors_["1095ui_story"]) then
					arg_223_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1095ui_story"]) and arg_223_1.var_.characterEffect1095ui_story then
				arg_223_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_226_2 = arg_223_1.actors_["1084ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = var_226_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_3 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.characterEffect1084ui_story and not isNil(var_226_2) then
					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_3)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1084ui_story then
				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_226_4 = 0
			local var_226_5 = 0.85

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(319941053)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 34 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 34)

				if (34 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 34)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941053", "story_v_out_319941.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941053", "story_v_out_319941.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_319941", "319941053", "story_v_out_319941.awb")

						arg_223_1:RecordAudio("319941053", var_226_11)
						arg_223_1:RecordAudio("319941053", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_319941", "319941053", "story_v_out_319941.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_319941", "319941053", "story_v_out_319941.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319941054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319941054
		arg_227_1.duration_ = 8.27

		local var_227_0 = {
			zh = 6.966,
			ja = 8.266
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
				arg_227_0:Play319941055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1095ui_story"]) and arg_227_1.var_.characterEffect1095ui_story == nil then
				arg_227_1.var_.characterEffect1095ui_story = arg_227_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1095ui_story"]) then
				if arg_227_1.var_.characterEffect1095ui_story and not isNil(arg_227_1.actors_["1095ui_story"]) then
					arg_227_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1095ui_story"]) and arg_227_1.var_.characterEffect1095ui_story then
				arg_227_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_230_1 = arg_227_1.actors_["1084ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1084ui_story == nil then
				arg_227_1.var_.characterEffect1084ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1084ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1084ui_story then
				arg_227_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = 0
			local var_230_5 = 0.95

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(319941054)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 38 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 38)

				if (38 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 38)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941054", "story_v_out_319941.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941054", "story_v_out_319941.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_319941", "319941054", "story_v_out_319941.awb")

						arg_227_1:RecordAudio("319941054", var_230_11)
						arg_227_1:RecordAudio("319941054", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_319941", "319941054", "story_v_out_319941.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_319941", "319941054", "story_v_out_319941.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play319941055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319941055
		arg_231_1.duration_ = 6.8

		local var_231_0 = {
			zh = 5.3,
			ja = 6.8
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play319941056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1095ui_story"]) and arg_231_1.var_.characterEffect1095ui_story == nil then
				arg_231_1.var_.characterEffect1095ui_story = arg_231_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1095ui_story"]) then
				if arg_231_1.var_.characterEffect1095ui_story and not isNil(arg_231_1.actors_["1095ui_story"]) then
					arg_231_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1095ui_story"]) and arg_231_1.var_.characterEffect1095ui_story then
				arg_231_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_234_2 = arg_231_1.actors_["1084ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_2) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_3)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_234_4 = 0
			local var_234_5 = 0.65

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(319941055)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 26 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 26)

				if (26 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 26)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941055", "story_v_out_319941.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941055", "story_v_out_319941.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_319941", "319941055", "story_v_out_319941.awb")

						arg_231_1:RecordAudio("319941055", var_234_11)
						arg_231_1:RecordAudio("319941055", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319941", "319941055", "story_v_out_319941.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319941", "319941055", "story_v_out_319941.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play319941056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319941056
		arg_235_1.duration_ = 6.27

		local var_235_0 = {
			zh = 4.2,
			ja = 6.266
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
				arg_235_0:Play319941057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.5

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(319941056)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 20)

				if (20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 20)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941056", "story_v_out_319941.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941056", "story_v_out_319941.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_319941", "319941056", "story_v_out_319941.awb")

						arg_235_1:RecordAudio("319941056", var_238_6)
						arg_235_1:RecordAudio("319941056", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319941", "319941056", "story_v_out_319941.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319941", "319941056", "story_v_out_319941.awb")
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
	Play319941057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319941057
		arg_239_1.duration_ = 2

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319941058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = arg_239_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) then
				if arg_239_1.var_.characterEffect1084ui_story and not isNil(arg_239_1.actors_["1084ui_story"]) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_242_2 = arg_239_1.actors_["1095ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect1095ui_story == nil then
				arg_239_1.var_.characterEffect1095ui_story = var_242_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_3 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.characterEffect1095ui_story and not isNil(var_242_2) then
					arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_3)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect1095ui_story then
				arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_242_4 = 0
			local var_242_5 = 0.1

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(319941057)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 4 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 4)

				if (4 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 4)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941057", "story_v_out_319941.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941057", "story_v_out_319941.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_319941", "319941057", "story_v_out_319941.awb")

						arg_239_1:RecordAudio("319941057", var_242_11)
						arg_239_1:RecordAudio("319941057", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319941", "319941057", "story_v_out_319941.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319941", "319941057", "story_v_out_319941.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319941058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319941058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play319941059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.775

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(319941058).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 31 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 31)

				if (31 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 31)) > 0 and var_246_2 < var_246_5 then
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
	Play319941059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319941059
		arg_247_1.duration_ = 8.4

		local var_247_0 = {
			zh = 6.933,
			ja = 8.4
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
				arg_247_0:Play319941060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_250_2 = 0
			local var_250_3 = 0.9

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(319941059)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 36 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 36)

				if (36 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 36)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941059", "story_v_out_319941.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941059", "story_v_out_319941.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_319941", "319941059", "story_v_out_319941.awb")

						arg_247_1:RecordAudio("319941059", var_250_9)
						arg_247_1:RecordAudio("319941059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319941", "319941059", "story_v_out_319941.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319941", "319941059", "story_v_out_319941.awb")
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
	Play319941060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319941060
		arg_251_1.duration_ = 5.47

		local var_251_0 = {
			zh = 5.466,
			ja = 4.966
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
				arg_251_0:Play319941061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.7

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
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

				local var_254_1 = arg_251_1:GetWordFromCfg(319941060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 28 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 28)

				if (28 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 28)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941060", "story_v_out_319941.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941060", "story_v_out_319941.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_319941", "319941060", "story_v_out_319941.awb")

						arg_251_1:RecordAudio("319941060", var_254_6)
						arg_251_1:RecordAudio("319941060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319941", "319941060", "story_v_out_319941.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319941", "319941060", "story_v_out_319941.awb")
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
	Play319941061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319941061
		arg_255_1.duration_ = 9.93

		local var_255_0 = {
			zh = 9.933,
			ja = 9.666
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
				arg_255_0:Play319941062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_258_0 = 0
			local var_258_1 = 1.225

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_2 = arg_255_1:GetWordFromCfg(319941061)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 49 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 49)

				if (49 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 49)) > 0 and var_258_1 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941061", "story_v_out_319941.awb") ~= 0 then
					local var_258_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941061", "story_v_out_319941.awb") / 1000

					if var_258_6 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_0
					end

					if var_258_2.prefab_name ~= "" and arg_255_1.actors_[var_258_2.prefab_name] ~= nil then
						local var_258_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_2.prefab_name].transform, "story_v_out_319941", "319941061", "story_v_out_319941.awb")

						arg_255_1:RecordAudio("319941061", var_258_7)
						arg_255_1:RecordAudio("319941061", var_258_7)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319941", "319941061", "story_v_out_319941.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319941", "319941061", "story_v_out_319941.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_8 and arg_255_1.time_ < var_258_0 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play319941062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319941062
		arg_259_1.duration_ = 4.8

		local var_259_0 = {
			zh = 2.566,
			ja = 4.8
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
				arg_259_0:Play319941063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1095ui_story"]) and arg_259_1.var_.characterEffect1095ui_story == nil then
				arg_259_1.var_.characterEffect1095ui_story = arg_259_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1095ui_story"]) then
				if arg_259_1.var_.characterEffect1095ui_story and not isNil(arg_259_1.actors_["1095ui_story"]) then
					arg_259_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1095ui_story"]) and arg_259_1.var_.characterEffect1095ui_story then
				arg_259_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_2 = arg_259_1.actors_["1084ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_3 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_2) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_3)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_262_4 = 0
			local var_262_5 = 0.35

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(319941062)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)

				if (14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941062", "story_v_out_319941.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941062", "story_v_out_319941.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_319941", "319941062", "story_v_out_319941.awb")

						arg_259_1:RecordAudio("319941062", var_262_11)
						arg_259_1:RecordAudio("319941062", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319941", "319941062", "story_v_out_319941.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319941", "319941062", "story_v_out_319941.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play319941063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 319941063
		arg_263_1.duration_ = 3.53

		local var_263_0 = {
			zh = 2.8,
			ja = 3.533
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
				arg_263_0:Play319941064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1095ui_story"]) and arg_263_1.var_.characterEffect1095ui_story == nil then
				arg_263_1.var_.characterEffect1095ui_story = arg_263_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1095ui_story"]) then
				if arg_263_1.var_.characterEffect1095ui_story and not isNil(arg_263_1.actors_["1095ui_story"]) then
					arg_263_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1095ui_story"]) and arg_263_1.var_.characterEffect1095ui_story then
				arg_263_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["1084ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1084ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story then
				arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_266_4 = 0
			local var_266_5 = 0.35

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(319941063)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 14 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 14)

				if (14 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 14)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941063", "story_v_out_319941.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941063", "story_v_out_319941.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_319941", "319941063", "story_v_out_319941.awb")

						arg_263_1:RecordAudio("319941063", var_266_11)
						arg_263_1:RecordAudio("319941063", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_319941", "319941063", "story_v_out_319941.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_319941", "319941063", "story_v_out_319941.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play319941064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 319941064
		arg_267_1.duration_ = 5.1

		local var_267_0 = {
			zh = 4.566,
			ja = 5.1
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
				arg_267_0:Play319941065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story == nil then
				arg_267_1.var_.characterEffect1084ui_story = arg_267_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) then
				if arg_267_1.var_.characterEffect1084ui_story and not isNil(arg_267_1.actors_["1084ui_story"]) then
					arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story then
				arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.425

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(319941064)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_6 = 17 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_4) / 17)

				if (17 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_4) / 17)) > 0 and var_270_2 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941064", "story_v_out_319941.awb") ~= 0 then
					local var_270_7 = manager.audio:GetVoiceLength("story_v_out_319941", "319941064", "story_v_out_319941.awb") / 1000

					if var_270_7 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_1
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_319941", "319941064", "story_v_out_319941.awb")

						arg_267_1:RecordAudio("319941064", var_270_8)
						arg_267_1:RecordAudio("319941064", var_270_8)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_319941", "319941064", "story_v_out_319941.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_319941", "319941064", "story_v_out_319941.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_9 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_9 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_9

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_9 and arg_267_1.time_ < var_270_1 + var_270_9 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play319941065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319941065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play319941066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.85

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(319941065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 34 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 34)

				if (34 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 34)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play319941066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319941066
		arg_275_1.duration_ = 10.37

		local var_275_0 = {
			zh = 6.799999999999,
			ja = 10.365999999999
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
				arg_275_0:Play319941067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if arg_275_1.bgs_.ST70 == nil then
				local var_278_0 = Object.Instantiate(arg_275_1.paintGo_)

				var_278_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST70")
				var_278_0.name = "ST70"
				var_278_0.transform.parent = arg_275_1.stage_.transform
				var_278_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.bgs_.ST70 = var_278_0
			end

			if 2 < arg_275_1.time_ and arg_275_1.time_ <= 2 + arg_278_0 then
				local var_278_1 = arg_275_1.bgs_.ST70

				arg_275_1.bgs_.ST70.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_278_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_2 = var_278_1:GetComponent("SpriteRenderer")

				if var_278_2 and var_278_2.sprite then
					local var_278_3 = 2 * (var_278_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_278_1.transform.localScale = Vector3.New(var_278_3 / var_278_2.sprite.bounds.size.y < var_278_3 * manager.ui.mainCameraCom_.aspect / var_278_2.sprite.bounds.size.x and var_278_3 * manager.ui.mainCameraCom_.aspect / var_278_2.sprite.bounds.size.x or var_278_3 / var_278_2.sprite.bounds.size.y, var_278_3 / var_278_2.sprite.bounds.size.y < var_278_3 * manager.ui.mainCameraCom_.aspect / var_278_2.sprite.bounds.size.x and var_278_3 * manager.ui.mainCameraCom_.aspect / var_278_2.sprite.bounds.size.x or var_278_3 / var_278_2.sprite.bounds.size.y, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "ST70" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_4 = 3.999999999999

			if 3.999999999999 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			if arg_275_1.time_ >= var_278_4 + 0.3 and arg_275_1.time_ < var_278_4 + 0.3 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			local var_278_5 = 0

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_6 = 2

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_6 then
				local var_278_7 = Color.New(0, 0, 0)

				var_278_7.a = Mathf.Lerp(0, 1, (arg_275_1.time_ - var_278_5) / var_278_6)
				arg_275_1.mask_.color = var_278_7
			end

			if arg_275_1.time_ >= var_278_5 + var_278_6 and arg_275_1.time_ < var_278_5 + var_278_6 + arg_278_0 then
				local var_278_8 = Color.New(0, 0, 0)

				var_278_8.a = 1
				arg_275_1.mask_.color = var_278_8
			end

			local var_278_9 = 2

			if 2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_10 = 2

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 then
				local var_278_11 = Color.New(0, 0, 0)

				var_278_11.a = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_9) / var_278_10)
				arg_275_1.mask_.color = var_278_11
			end

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 then
				local var_278_12 = Color.New(0, 0, 0)

				arg_275_1.mask_.enabled = false
				var_278_12.a = 0
				arg_275_1.mask_.color = var_278_12
			end

			local var_278_13 = arg_275_1.actors_["10069ui_story"].transform

			if 3.8 < arg_275_1.time_ and arg_275_1.time_ <= 3.8 + arg_278_0 then
				arg_275_1.var_.moveOldPos10069ui_story = var_278_13.localPosition
			end

			local var_278_14 = 0.001

			if 3.8 <= arg_275_1.time_ and arg_275_1.time_ < 3.8 + var_278_14 then
				var_278_13.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_275_1.time_ - 3.8) / var_278_14)
				var_278_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_13.position).x, (manager.ui.mainCamera.transform.position - var_278_13.position).y, (manager.ui.mainCamera.transform.position - var_278_13.position).z)
				var_278_13.localEulerAngles.z = 0
				var_278_13.localEulerAngles.x = 0
				var_278_13.localEulerAngles = var_278_13.localEulerAngles
			end

			if arg_275_1.time_ >= 3.8 + var_278_14 and arg_275_1.time_ < 3.8 + var_278_14 + arg_278_0 then
				var_278_13.localPosition = Vector3.New(0, -1.08, -6.33)
				var_278_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_13.position).x, (manager.ui.mainCamera.transform.position - var_278_13.position).y, (manager.ui.mainCamera.transform.position - var_278_13.position).z)
				var_278_13.localEulerAngles.z = 0
				var_278_13.localEulerAngles.x = 0
				var_278_13.localEulerAngles = var_278_13.localEulerAngles
			end

			local var_278_15 = arg_275_1.actors_["10069ui_story"]

			if 3.8 < arg_275_1.time_ and arg_275_1.time_ <= 3.8 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.characterEffect10069ui_story == nil then
				arg_275_1.var_.characterEffect10069ui_story = var_278_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_16 = 0.200000002980232

			if 3.8 <= arg_275_1.time_ and arg_275_1.time_ < 3.8 + var_278_16 and not isNil(var_278_15) then
				if arg_275_1.var_.characterEffect10069ui_story and not isNil(var_278_15) then
					arg_275_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 3.8 + var_278_16 and arg_275_1.time_ < 3.8 + var_278_16 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.characterEffect10069ui_story then
				arg_275_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 3.8 < arg_275_1.time_ and arg_275_1.time_ <= 3.8 + arg_278_0 then
				arg_275_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 3.8 < arg_275_1.time_ and arg_275_1.time_ <= 3.8 + arg_278_0 then
				arg_275_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_18 = arg_275_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 1.96599999815226 + arg_278_0 then
				arg_275_1.var_.moveOldPos1084ui_story = var_278_18.localPosition
			end

			local var_278_19 = 0.001

			if 1.96599999815226 <= arg_275_1.time_ and arg_275_1.time_ < 1.96599999815226 + var_278_19 then
				var_278_18.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 1.96599999815226) / var_278_19)
				var_278_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_18.position).x, (manager.ui.mainCamera.transform.position - var_278_18.position).y, (manager.ui.mainCamera.transform.position - var_278_18.position).z)
				var_278_18.localEulerAngles.z = 0
				var_278_18.localEulerAngles.x = 0
				var_278_18.localEulerAngles = var_278_18.localEulerAngles
			end

			if arg_275_1.time_ >= 1.96599999815226 + var_278_19 and arg_275_1.time_ < 1.96599999815226 + var_278_19 + arg_278_0 then
				var_278_18.localPosition = Vector3.New(0, 100, 0)
				var_278_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_18.position).x, (manager.ui.mainCamera.transform.position - var_278_18.position).y, (manager.ui.mainCamera.transform.position - var_278_18.position).z)
				var_278_18.localEulerAngles.z = 0
				var_278_18.localEulerAngles.x = 0
				var_278_18.localEulerAngles = var_278_18.localEulerAngles
			end

			local var_278_20 = arg_275_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 1.96599999815226 + arg_278_0 then
				arg_275_1.var_.moveOldPos1095ui_story = var_278_20.localPosition
			end

			local var_278_21 = 0.001

			if 1.96599999815226 <= arg_275_1.time_ and arg_275_1.time_ < 1.96599999815226 + var_278_21 then
				var_278_20.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 1.96599999815226) / var_278_21)
				var_278_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_20.position).x, (manager.ui.mainCamera.transform.position - var_278_20.position).y, (manager.ui.mainCamera.transform.position - var_278_20.position).z)
				var_278_20.localEulerAngles.z = 0
				var_278_20.localEulerAngles.x = 0
				var_278_20.localEulerAngles = var_278_20.localEulerAngles
			end

			if arg_275_1.time_ >= 1.96599999815226 + var_278_21 and arg_275_1.time_ < 1.96599999815226 + var_278_21 + arg_278_0 then
				var_278_20.localPosition = Vector3.New(0, 100, 0)
				var_278_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_20.position).x, (manager.ui.mainCamera.transform.position - var_278_20.position).y, (manager.ui.mainCamera.transform.position - var_278_20.position).z)
				var_278_20.localEulerAngles.z = 0
				var_278_20.localEulerAngles.x = 0
				var_278_20.localEulerAngles = var_278_20.localEulerAngles
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_22 = 3.999999999999
			local var_278_23 = 0.375

			if 3.999999999999 < arg_275_1.time_ and arg_275_1.time_ <= var_278_22 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_24 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_24:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_25 = arg_275_1:GetWordFromCfg(319941066)
				local var_278_26 = arg_275_1:FormatText(var_278_25.content)

				arg_275_1.text_.text = var_278_26

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_28 = 15 <= 0 and var_278_23 or var_278_23 * (utf8.len(var_278_26) / 15)

				if (15 <= 0 and var_278_23 or var_278_23 * (utf8.len(var_278_26) / 15)) > 0 and var_278_23 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28
					var_278_22 = var_278_22 + 0.3

					if var_278_28 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_22
					end
				end

				arg_275_1.text_.text = var_278_26
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941066", "story_v_out_319941.awb") ~= 0 then
					local var_278_29 = manager.audio:GetVoiceLength("story_v_out_319941", "319941066", "story_v_out_319941.awb") / 1000

					if var_278_29 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_22
					end

					if var_278_25.prefab_name ~= "" and arg_275_1.actors_[var_278_25.prefab_name] ~= nil then
						local var_278_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_25.prefab_name].transform, "story_v_out_319941", "319941066", "story_v_out_319941.awb")

						arg_275_1:RecordAudio("319941066", var_278_30)
						arg_275_1:RecordAudio("319941066", var_278_30)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319941", "319941066", "story_v_out_319941.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319941", "319941066", "story_v_out_319941.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = var_278_22 + 0.3
			local var_278_32 = math.max(var_278_23, arg_275_1.talkMaxDuration)

			if var_278_22 + 0.3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_31 + var_278_32 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_31) / var_278_32

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_31 + var_278_32 and arg_275_1.time_ < var_278_31 + var_278_32 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play319941067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319941067
		arg_281_1.duration_ = 6.7

		local var_281_0 = {
			zh = 4.6,
			ja = 6.7
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play319941068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10075ui_story = arg_281_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).z)
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles = arg_281_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_281_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10075ui_story"].transform.position).z)
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10075ui_story"].transform.localEulerAngles = arg_281_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["10075ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10075ui_story == nil then
				arg_281_1.var_.characterEffect10075ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect10075ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10075ui_story then
				arg_281_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_284_4 = arg_281_1.actors_["10069ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10069ui_story = var_284_4.localPosition
			end

			local var_284_5 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 then
				var_284_4.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_5)
				var_284_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_4.position).x, (manager.ui.mainCamera.transform.position - var_284_4.position).y, (manager.ui.mainCamera.transform.position - var_284_4.position).z)
				var_284_4.localEulerAngles.z = 0
				var_284_4.localEulerAngles.x = 0
				var_284_4.localEulerAngles = var_284_4.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 then
				var_284_4.localPosition = Vector3.New(0, 100, 0)
				var_284_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_4.position).x, (manager.ui.mainCamera.transform.position - var_284_4.position).y, (manager.ui.mainCamera.transform.position - var_284_4.position).z)
				var_284_4.localEulerAngles.z = 0
				var_284_4.localEulerAngles.x = 0
				var_284_4.localEulerAngles = var_284_4.localEulerAngles
			end

			local var_284_6 = arg_281_1.actors_["10069ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10069ui_story == nil then
				arg_281_1.var_.characterEffect10069ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_7 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 and not isNil(var_284_6) then
				if arg_281_1.var_.characterEffect10069ui_story and not isNil(var_284_6) then
					arg_281_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_7)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10069ui_story then
				arg_281_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_284_8 = 0
			local var_284_9 = 0.6

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(319941067)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 24 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 24)

				if (24 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 24)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941067", "story_v_out_319941.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941067", "story_v_out_319941.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_319941", "319941067", "story_v_out_319941.awb")

						arg_281_1:RecordAudio("319941067", var_284_15)
						arg_281_1:RecordAudio("319941067", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319941", "319941067", "story_v_out_319941.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319941", "319941067", "story_v_out_319941.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319941068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319941068
		arg_285_1.duration_ = 6.4

		local var_285_0 = {
			zh = 4.166,
			ja = 6.4
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play319941069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.375

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(319941068)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 15 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 15)

				if (15 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 15)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941068", "story_v_out_319941.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941068", "story_v_out_319941.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_319941", "319941068", "story_v_out_319941.awb")

						arg_285_1:RecordAudio("319941068", var_288_6)
						arg_285_1:RecordAudio("319941068", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319941", "319941068", "story_v_out_319941.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319941", "319941068", "story_v_out_319941.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play319941069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319941069
		arg_289_1.duration_ = 2

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play319941070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.actors_["10074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10074ui_story"))) then
				local var_292_0 = Object.Instantiate(Asset.Load("Char/" .. "10074ui_story"), arg_289_1.stage_.transform)

				var_292_0.name = "10074ui_story"
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["10074ui_story"] = var_292_0

				local var_292_1 = var_292_0:GetComponentInChildren(typeof(CharacterEffect))

				var_292_1.enabled = true

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end

				arg_289_1:ShowWeapon(var_292_1.transform, false)

				arg_289_1.var_["10074ui_story" .. "Animator"] = var_292_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_289_1.var_["10074ui_story" .. "Animator"].applyRootMotion = true
				arg_289_1.var_["10074ui_story" .. "LipSync"] = var_292_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_292_3 = arg_289_1.actors_["10074ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10074ui_story = var_292_3.localPosition
			end

			local var_292_4 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_3.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10074ui_story, Vector3.New(0, -0.75, -6.18), (arg_289_1.time_ - 0) / var_292_4)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_3.localPosition = Vector3.New(0, -0.75, -6.18)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			local var_292_5 = arg_289_1.actors_["10074ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect10074ui_story == nil then
				arg_289_1.var_.characterEffect10074ui_story = var_292_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.characterEffect10074ui_story and not isNil(var_292_5) then
					arg_289_1.var_.characterEffect10074ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect10074ui_story then
				arg_289_1.var_.characterEffect10074ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10074ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action3_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_292_8 = arg_289_1.actors_["10075ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10075ui_story = var_292_8.localPosition
			end

			local var_292_9 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_9 then
				var_292_8.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_9)
				var_292_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_8.position).x, (manager.ui.mainCamera.transform.position - var_292_8.position).y, (manager.ui.mainCamera.transform.position - var_292_8.position).z)
				var_292_8.localEulerAngles.z = 0
				var_292_8.localEulerAngles.x = 0
				var_292_8.localEulerAngles = var_292_8.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_9 and arg_289_1.time_ < 0 + var_292_9 + arg_292_0 then
				var_292_8.localPosition = Vector3.New(0, 100, 0)
				var_292_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_8.position).x, (manager.ui.mainCamera.transform.position - var_292_8.position).y, (manager.ui.mainCamera.transform.position - var_292_8.position).z)
				var_292_8.localEulerAngles.z = 0
				var_292_8.localEulerAngles.x = 0
				var_292_8.localEulerAngles = var_292_8.localEulerAngles
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_10 = 0.7
			local var_292_11 = 0.075

			if 0.7 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_12 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_12:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_13 = arg_289_1:GetWordFromCfg(319941069)
				local var_292_14 = arg_289_1:FormatText(var_292_13.content)

				arg_289_1.text_.text = var_292_14

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 3 <= 0 and var_292_11 or var_292_11 * (utf8.len(var_292_14) / 3)

				if (3 <= 0 and var_292_11 or var_292_11 * (utf8.len(var_292_14) / 3)) > 0 and var_292_11 < var_292_16 then
					arg_289_1.talkMaxDuration = var_292_16
					var_292_10 = var_292_10 + 0.3

					if var_292_16 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_16 + var_292_10
					end
				end

				arg_289_1.text_.text = var_292_14
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941069", "story_v_out_319941.awb") ~= 0 then
					local var_292_17 = manager.audio:GetVoiceLength("story_v_out_319941", "319941069", "story_v_out_319941.awb") / 1000

					if var_292_17 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_17 + var_292_10
					end

					if var_292_13.prefab_name ~= "" and arg_289_1.actors_[var_292_13.prefab_name] ~= nil then
						local var_292_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_13.prefab_name].transform, "story_v_out_319941", "319941069", "story_v_out_319941.awb")

						arg_289_1:RecordAudio("319941069", var_292_18)
						arg_289_1:RecordAudio("319941069", var_292_18)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_319941", "319941069", "story_v_out_319941.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_319941", "319941069", "story_v_out_319941.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_19 = var_292_10 + 0.3
			local var_292_20 = math.max(var_292_11, arg_289_1.talkMaxDuration)

			if var_292_10 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_19 + var_292_20 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_19) / var_292_20

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_19 + var_292_20 and arg_289_1.time_ < var_292_19 + var_292_20 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play319941070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319941070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319941071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10074ui_story = arg_295_1.actors_["10074ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["10074ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10074ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["10074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).z)
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles = arg_295_1.actors_["10074ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["10074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["10074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10074ui_story"].transform.position).z)
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10074ui_story"].transform.localEulerAngles = arg_295_1.actors_["10074ui_story"].transform.localEulerAngles
			end

			local var_298_1 = 0
			local var_298_2 = 1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(319941070).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 40 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 40)

				if (40 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 40)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10074ui_story",
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
	Play319941071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319941071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319941072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.175

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(319941071).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 47 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 47)

				if (47 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 47)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play319941072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319941072
		arg_303_1.duration_ = 4.43

		local var_303_0 = {
			zh = 1.999999999999,
			ja = 4.433
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
				arg_303_0:Play319941073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1095ui_story = arg_303_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).z)
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles = arg_303_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_303_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1095ui_story"].transform.position).z)
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1095ui_story"].transform.localEulerAngles = arg_303_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1095ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1095ui_story == nil then
				arg_303_1.var_.characterEffect1095ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1095ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1095ui_story then
				arg_303_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_4 = arg_303_1.actors_["10075ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10075ui_story = var_306_4.localPosition
			end

			local var_306_5 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_5 then
				var_306_4.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_5)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_5 and arg_303_1.time_ < 0 + var_306_5 + arg_306_0 then
				var_306_4.localPosition = Vector3.New(0, 100, 0)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			local var_306_6 = 0
			local var_306_7 = 0.2

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_8 = arg_303_1:GetWordFromCfg(319941072)
				local var_306_9 = arg_303_1:FormatText(var_306_8.content)

				arg_303_1.text_.text = var_306_9

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 8 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 8)

				if (8 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 8)) > 0 and var_306_7 < var_306_11 then
					arg_303_1.talkMaxDuration = var_306_11

					if var_306_11 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_11 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_9
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941072", "story_v_out_319941.awb") ~= 0 then
					local var_306_12 = manager.audio:GetVoiceLength("story_v_out_319941", "319941072", "story_v_out_319941.awb") / 1000

					if var_306_12 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_6
					end

					if var_306_8.prefab_name ~= "" and arg_303_1.actors_[var_306_8.prefab_name] ~= nil then
						local var_306_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_8.prefab_name].transform, "story_v_out_319941", "319941072", "story_v_out_319941.awb")

						arg_303_1:RecordAudio("319941072", var_306_13)
						arg_303_1:RecordAudio("319941072", var_306_13)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319941", "319941072", "story_v_out_319941.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319941", "319941072", "story_v_out_319941.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319941073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319941073
		arg_307_1.duration_ = 10.47

		local var_307_0 = {
			zh = 10.466,
			ja = 8.9
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319941074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10075ui_story = arg_307_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).z)
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles = arg_307_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_307_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10075ui_story"].transform.position).z)
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10075ui_story"].transform.localEulerAngles = arg_307_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["10075ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10075ui_story == nil then
				arg_307_1.var_.characterEffect10075ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect10075ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10075ui_story then
				arg_307_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_4 = arg_307_1.actors_["1095ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1095ui_story = var_310_4.localPosition
			end

			local var_310_5 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_5 then
				var_310_4.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_5)
				var_310_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_4.position).x, (manager.ui.mainCamera.transform.position - var_310_4.position).y, (manager.ui.mainCamera.transform.position - var_310_4.position).z)
				var_310_4.localEulerAngles.z = 0
				var_310_4.localEulerAngles.x = 0
				var_310_4.localEulerAngles = var_310_4.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_5 and arg_307_1.time_ < 0 + var_310_5 + arg_310_0 then
				var_310_4.localPosition = Vector3.New(0, 100, 0)
				var_310_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_4.position).x, (manager.ui.mainCamera.transform.position - var_310_4.position).y, (manager.ui.mainCamera.transform.position - var_310_4.position).z)
				var_310_4.localEulerAngles.z = 0
				var_310_4.localEulerAngles.x = 0
				var_310_4.localEulerAngles = var_310_4.localEulerAngles
			end

			local var_310_6 = arg_307_1.actors_["1095ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_6) and arg_307_1.var_.characterEffect1095ui_story == nil then
				arg_307_1.var_.characterEffect1095ui_story = var_310_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_7 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 and not isNil(var_310_6) then
				if arg_307_1.var_.characterEffect1095ui_story and not isNil(var_310_6) then
					arg_307_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_7)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 and not isNil(var_310_6) and arg_307_1.var_.characterEffect1095ui_story then
				arg_307_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_310_8 = 0
			local var_310_9 = 0.875

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(319941073)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 35 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 35)

				if (35 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 35)) > 0 and var_310_9 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941073", "story_v_out_319941.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941073", "story_v_out_319941.awb") / 1000

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_319941", "319941073", "story_v_out_319941.awb")

						arg_307_1:RecordAudio("319941073", var_310_15)
						arg_307_1:RecordAudio("319941073", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319941", "319941073", "story_v_out_319941.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319941", "319941073", "story_v_out_319941.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_16 and arg_307_1.time_ < var_310_8 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play319941074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319941074
		arg_311_1.duration_ = 4.2

		local var_311_0 = {
			zh = 3.3,
			ja = 4.2
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play319941075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_314_0 = 0
			local var_314_1 = 0.375

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(319941074)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 15 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 15)

				if (15 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 15)) > 0 and var_314_1 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941074", "story_v_out_319941.awb") ~= 0 then
					local var_314_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941074", "story_v_out_319941.awb") / 1000

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end

					if var_314_2.prefab_name ~= "" and arg_311_1.actors_[var_314_2.prefab_name] ~= nil then
						local var_314_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_2.prefab_name].transform, "story_v_out_319941", "319941074", "story_v_out_319941.awb")

						arg_311_1:RecordAudio("319941074", var_314_7)
						arg_311_1:RecordAudio("319941074", var_314_7)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319941", "319941074", "story_v_out_319941.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319941", "319941074", "story_v_out_319941.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play319941075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 319941075
		arg_315_1.duration_ = 7.27

		local var_315_0 = {
			zh = 2.766,
			ja = 7.266
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play319941076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1084ui_story = arg_315_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).z)
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles = arg_315_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_315_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).z)
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles = arg_315_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1084ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1084ui_story == nil then
				arg_315_1.var_.characterEffect1084ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1084ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1084ui_story then
				arg_315_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_318_4 = arg_315_1.actors_["10075ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10075ui_story = var_318_4.localPosition
			end

			local var_318_5 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 then
				var_318_4.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_315_1.time_ - 0) / var_318_5)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 then
				var_318_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			local var_318_6 = arg_315_1.actors_["10075ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_6) and arg_315_1.var_.characterEffect10075ui_story == nil then
				arg_315_1.var_.characterEffect10075ui_story = var_318_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_7 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 and not isNil(var_318_6) then
				if arg_315_1.var_.characterEffect10075ui_story and not isNil(var_318_6) then
					arg_315_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_7)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 and not isNil(var_318_6) and arg_315_1.var_.characterEffect10075ui_story then
				arg_315_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_318_8 = 0
			local var_318_9 = 0.325

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_10 = arg_315_1:GetWordFromCfg(319941075)
				local var_318_11 = arg_315_1:FormatText(var_318_10.content)

				arg_315_1.text_.text = var_318_11

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 13 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 13)

				if (13 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 13)) > 0 and var_318_9 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_11
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941075", "story_v_out_319941.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941075", "story_v_out_319941.awb") / 1000

					if var_318_14 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_8
					end

					if var_318_10.prefab_name ~= "" and arg_315_1.actors_[var_318_10.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_10.prefab_name].transform, "story_v_out_319941", "319941075", "story_v_out_319941.awb")

						arg_315_1:RecordAudio("319941075", var_318_15)
						arg_315_1:RecordAudio("319941075", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_319941", "319941075", "story_v_out_319941.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_319941", "319941075", "story_v_out_319941.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_9, arg_315_1.talkMaxDuration)

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_8) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_8 + var_318_16 and arg_315_1.time_ < var_318_8 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play319941076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 319941076
		arg_319_1.duration_ = 6.8

		local var_319_0 = {
			zh = 6.8,
			ja = 5.066
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play319941077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1084ui_story"]) and arg_319_1.var_.characterEffect1084ui_story == nil then
				arg_319_1.var_.characterEffect1084ui_story = arg_319_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1084ui_story"]) then
				if arg_319_1.var_.characterEffect1084ui_story and not isNil(arg_319_1.actors_["1084ui_story"]) then
					arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1084ui_story"]) and arg_319_1.var_.characterEffect1084ui_story then
				arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_322_1 = arg_319_1.actors_["10075ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10075ui_story == nil then
				arg_319_1.var_.characterEffect10075ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect10075ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10075ui_story then
				arg_319_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			local var_322_4 = 0
			local var_322_5 = 0.55

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(319941076)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 22 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 22)

				if (22 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 22)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941076", "story_v_out_319941.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941076", "story_v_out_319941.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_319941", "319941076", "story_v_out_319941.awb")

						arg_319_1:RecordAudio("319941076", var_322_11)
						arg_319_1:RecordAudio("319941076", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_319941", "319941076", "story_v_out_319941.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_319941", "319941076", "story_v_out_319941.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play319941077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319941077
		arg_323_1.duration_ = 4.4

		local var_323_0 = {
			zh = 3.3,
			ja = 4.4
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play319941078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1084ui_story"]) and arg_323_1.var_.characterEffect1084ui_story == nil then
				arg_323_1.var_.characterEffect1084ui_story = arg_323_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1084ui_story"]) then
				if arg_323_1.var_.characterEffect1084ui_story and not isNil(arg_323_1.actors_["1084ui_story"]) then
					arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1084ui_story"]) and arg_323_1.var_.characterEffect1084ui_story then
				arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_326_2 = arg_323_1.actors_["10075ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect10075ui_story == nil then
				arg_323_1.var_.characterEffect10075ui_story = var_326_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_3 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.characterEffect10075ui_story and not isNil(var_326_2) then
					arg_323_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_3)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect10075ui_story then
				arg_323_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_326_4 = 0
			local var_326_5 = 0.4

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(319941077)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 16 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 16)

				if (16 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 16)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941077", "story_v_out_319941.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941077", "story_v_out_319941.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_out_319941", "319941077", "story_v_out_319941.awb")

						arg_323_1:RecordAudio("319941077", var_326_11)
						arg_323_1:RecordAudio("319941077", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319941", "319941077", "story_v_out_319941.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319941", "319941077", "story_v_out_319941.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play319941078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 319941078
		arg_327_1.duration_ = 7.93

		local var_327_0 = {
			zh = 5.033,
			ja = 7.933
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play319941079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10075ui_story"]) and arg_327_1.var_.characterEffect10075ui_story == nil then
				arg_327_1.var_.characterEffect10075ui_story = arg_327_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10075ui_story"]) then
				if arg_327_1.var_.characterEffect10075ui_story and not isNil(arg_327_1.actors_["10075ui_story"]) then
					arg_327_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10075ui_story"]) and arg_327_1.var_.characterEffect10075ui_story then
				arg_327_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_330_2 = arg_327_1.actors_["1084ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_3 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.characterEffect1084ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_3)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1084ui_story then
				arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_330_4 = 0
			local var_330_5 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(319941078)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 22 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 22)

				if (22 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 22)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941078", "story_v_out_319941.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941078", "story_v_out_319941.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_319941", "319941078", "story_v_out_319941.awb")

						arg_327_1:RecordAudio("319941078", var_330_11)
						arg_327_1:RecordAudio("319941078", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_319941", "319941078", "story_v_out_319941.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_319941", "319941078", "story_v_out_319941.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play319941079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 319941079
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play319941080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10075ui_story"]) and arg_331_1.var_.characterEffect10075ui_story == nil then
				arg_331_1.var_.characterEffect10075ui_story = arg_331_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10075ui_story"]) then
				if arg_331_1.var_.characterEffect10075ui_story and not isNil(arg_331_1.actors_["10075ui_story"]) then
					arg_331_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10075ui_story"]) and arg_331_1.var_.characterEffect10075ui_story then
				arg_331_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.75

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(319941079).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 30 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 30)

				if (30 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 30)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play319941080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 319941080
		arg_335_1.duration_ = 10.03

		local var_335_0 = {
			zh = 6.6,
			ja = 10.033
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play319941081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10075ui_story"]) and arg_335_1.var_.characterEffect10075ui_story == nil then
				arg_335_1.var_.characterEffect10075ui_story = arg_335_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10075ui_story"]) then
				if arg_335_1.var_.characterEffect10075ui_story and not isNil(arg_335_1.actors_["10075ui_story"]) then
					arg_335_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10075ui_story"]) and arg_335_1.var_.characterEffect10075ui_story then
				arg_335_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_338_2 = 0
			local var_338_3 = 0.675

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(319941080)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 27 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 27)

				if (27 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 27)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941080", "story_v_out_319941.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941080", "story_v_out_319941.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_out_319941", "319941080", "story_v_out_319941.awb")

						arg_335_1:RecordAudio("319941080", var_338_9)
						arg_335_1:RecordAudio("319941080", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_319941", "319941080", "story_v_out_319941.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_319941", "319941080", "story_v_out_319941.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play319941081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 319941081
		arg_339_1.duration_ = 5.2

		local var_339_0 = {
			zh = 2.633,
			ja = 5.2
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play319941082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1084ui_story"]) and arg_339_1.var_.characterEffect1084ui_story == nil then
				arg_339_1.var_.characterEffect1084ui_story = arg_339_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1084ui_story"]) then
				if arg_339_1.var_.characterEffect1084ui_story and not isNil(arg_339_1.actors_["1084ui_story"]) then
					arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1084ui_story"]) and arg_339_1.var_.characterEffect1084ui_story then
				arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4138")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_342_2 = arg_339_1.actors_["10075ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.characterEffect10075ui_story == nil then
				arg_339_1.var_.characterEffect10075ui_story = var_342_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_3 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.characterEffect10075ui_story and not isNil(var_342_2) then
					arg_339_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_3)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.characterEffect10075ui_story then
				arg_339_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_342_4 = 0
			local var_342_5 = 0.4

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(319941081)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 16 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 16)

				if (16 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 16)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941081", "story_v_out_319941.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941081", "story_v_out_319941.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_319941", "319941081", "story_v_out_319941.awb")

						arg_339_1:RecordAudio("319941081", var_342_11)
						arg_339_1:RecordAudio("319941081", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_319941", "319941081", "story_v_out_319941.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_319941", "319941081", "story_v_out_319941.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play319941082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 319941082
		arg_343_1.duration_ = 4.43

		local var_343_0 = {
			zh = 2.966,
			ja = 4.433
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play319941083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) and arg_343_1.var_.characterEffect1084ui_story == nil then
				arg_343_1.var_.characterEffect1084ui_story = arg_343_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) then
				if arg_343_1.var_.characterEffect1084ui_story and not isNil(arg_343_1.actors_["1084ui_story"]) then
					arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) and arg_343_1.var_.characterEffect1084ui_story then
				arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_346_1 = arg_343_1.actors_["10075ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect10075ui_story == nil then
				arg_343_1.var_.characterEffect10075ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect10075ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect10075ui_story then
				arg_343_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_346_4 = 0
			local var_346_5 = 0.175

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(319941082)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 7 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 7)

				if (7 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 7)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941082", "story_v_out_319941.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941082", "story_v_out_319941.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_out_319941", "319941082", "story_v_out_319941.awb")

						arg_343_1:RecordAudio("319941082", var_346_11)
						arg_343_1:RecordAudio("319941082", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_319941", "319941082", "story_v_out_319941.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_319941", "319941082", "story_v_out_319941.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_12 and arg_343_1.time_ < var_346_4 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play319941083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 319941083
		arg_347_1.duration_ = 12.77

		local var_347_0 = {
			zh = 7.06600000298023,
			ja = 12.7660000029802
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play319941084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1084ui_story"]) and arg_347_1.var_.characterEffect1084ui_story == nil then
				arg_347_1.var_.characterEffect1084ui_story = arg_347_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1084ui_story"]) then
				if arg_347_1.var_.characterEffect1084ui_story and not isNil(arg_347_1.actors_["1084ui_story"]) then
					arg_347_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1084ui_story"]) and arg_347_1.var_.characterEffect1084ui_story then
				arg_347_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_350_2 = arg_347_1.actors_["10075ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect10075ui_story == nil then
				arg_347_1.var_.characterEffect10075ui_story = var_350_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_3 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.characterEffect10075ui_story and not isNil(var_350_2) then
					arg_347_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_347_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_3)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect10075ui_story then
				arg_347_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_347_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_350_4 = 0.200000002980232
			local var_350_5 = 0.85

			if 0.200000002980232 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(319941083)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 34 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 34)

				if (34 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 34)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941083", "story_v_out_319941.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941083", "story_v_out_319941.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_out_319941", "319941083", "story_v_out_319941.awb")

						arg_347_1:RecordAudio("319941083", var_350_11)
						arg_347_1:RecordAudio("319941083", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_319941", "319941083", "story_v_out_319941.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_319941", "319941083", "story_v_out_319941.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play319941084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 319941084
		arg_351_1.duration_ = 4.73

		local var_351_0 = {
			zh = 2.166,
			ja = 4.733
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play319941085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1084ui_story"]) and arg_351_1.var_.characterEffect1084ui_story == nil then
				arg_351_1.var_.characterEffect1084ui_story = arg_351_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1084ui_story"]) then
				if arg_351_1.var_.characterEffect1084ui_story and not isNil(arg_351_1.actors_["1084ui_story"]) then
					arg_351_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1084ui_story"]) and arg_351_1.var_.characterEffect1084ui_story then
				arg_351_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_354_1 = arg_351_1.actors_["10075ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect10075ui_story == nil then
				arg_351_1.var_.characterEffect10075ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect10075ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect10075ui_story then
				arg_351_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_354_4 = 0
			local var_354_5 = 0.2

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(319941084)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 8 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 8)

				if (8 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 8)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941084", "story_v_out_319941.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941084", "story_v_out_319941.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_out_319941", "319941084", "story_v_out_319941.awb")

						arg_351_1:RecordAudio("319941084", var_354_11)
						arg_351_1:RecordAudio("319941084", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_319941", "319941084", "story_v_out_319941.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_319941", "319941084", "story_v_out_319941.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play319941085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 319941085
		arg_355_1.duration_ = 2.57

		local var_355_0 = {
			zh = 2.566,
			ja = 2.333
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play319941086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1084ui_story"]) and arg_355_1.var_.characterEffect1084ui_story == nil then
				arg_355_1.var_.characterEffect1084ui_story = arg_355_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1084ui_story"]) then
				if arg_355_1.var_.characterEffect1084ui_story and not isNil(arg_355_1.actors_["1084ui_story"]) then
					arg_355_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1084ui_story"]) and arg_355_1.var_.characterEffect1084ui_story then
				arg_355_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_358_2 = arg_355_1.actors_["10075ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect10075ui_story == nil then
				arg_355_1.var_.characterEffect10075ui_story = var_358_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_3 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.characterEffect10075ui_story and not isNil(var_358_2) then
					arg_355_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_355_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_3)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect10075ui_story then
				arg_355_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_355_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_358_4 = 0
			local var_358_5 = 0.3

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(319941085)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 12 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 12)

				if (12 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 12)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941085", "story_v_out_319941.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941085", "story_v_out_319941.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_319941", "319941085", "story_v_out_319941.awb")

						arg_355_1:RecordAudio("319941085", var_358_11)
						arg_355_1:RecordAudio("319941085", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_319941", "319941085", "story_v_out_319941.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_319941", "319941085", "story_v_out_319941.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play319941086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 319941086
		arg_359_1.duration_ = 8.2

		local var_359_0 = {
			zh = 8.2,
			ja = 7.466
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play319941087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10075ui_story"]) and arg_359_1.var_.characterEffect10075ui_story == nil then
				arg_359_1.var_.characterEffect10075ui_story = arg_359_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10075ui_story"]) then
				if arg_359_1.var_.characterEffect10075ui_story and not isNil(arg_359_1.actors_["10075ui_story"]) then
					arg_359_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10075ui_story"]) and arg_359_1.var_.characterEffect10075ui_story then
				arg_359_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_2")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_2 = arg_359_1.actors_["1084ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect1084ui_story == nil then
				arg_359_1.var_.characterEffect1084ui_story = var_362_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_3 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.characterEffect1084ui_story and not isNil(var_362_2) then
					arg_359_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_3)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect1084ui_story then
				arg_359_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_362_4 = 0
			local var_362_5 = 0.8

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(319941086)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 32 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 32)

				if (32 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 32)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941086", "story_v_out_319941.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941086", "story_v_out_319941.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_319941", "319941086", "story_v_out_319941.awb")

						arg_359_1:RecordAudio("319941086", var_362_11)
						arg_359_1:RecordAudio("319941086", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_319941", "319941086", "story_v_out_319941.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_319941", "319941086", "story_v_out_319941.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play319941087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 319941087
		arg_363_1.duration_ = 11.77

		local var_363_0 = {
			zh = 7.933,
			ja = 11.766
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play319941088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_366_0 = 0
			local var_366_1 = 0.95

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_2 = arg_363_1:GetWordFromCfg(319941087)
				local var_366_3 = arg_363_1:FormatText(var_366_2.content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 38 <= 0 and var_366_1 or var_366_1 * (utf8.len(var_366_3) / 38)

				if (38 <= 0 and var_366_1 or var_366_1 * (utf8.len(var_366_3) / 38)) > 0 and var_366_1 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941087", "story_v_out_319941.awb") ~= 0 then
					local var_366_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941087", "story_v_out_319941.awb") / 1000

					if var_366_6 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_0
					end

					if var_366_2.prefab_name ~= "" and arg_363_1.actors_[var_366_2.prefab_name] ~= nil then
						local var_366_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_2.prefab_name].transform, "story_v_out_319941", "319941087", "story_v_out_319941.awb")

						arg_363_1:RecordAudio("319941087", var_366_7)
						arg_363_1:RecordAudio("319941087", var_366_7)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_319941", "319941087", "story_v_out_319941.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_319941", "319941087", "story_v_out_319941.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_8 and arg_363_1.time_ < var_366_0 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play319941088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 319941088
		arg_367_1.duration_ = 14.3

		local var_367_0 = {
			zh = 8.1,
			ja = 14.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play319941089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.95

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(319941088)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 38 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 38)

				if (38 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 38)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941088", "story_v_out_319941.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_319941", "319941088", "story_v_out_319941.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_319941", "319941088", "story_v_out_319941.awb")

						arg_367_1:RecordAudio("319941088", var_370_6)
						arg_367_1:RecordAudio("319941088", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_319941", "319941088", "story_v_out_319941.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_319941", "319941088", "story_v_out_319941.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play319941089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 319941089
		arg_371_1.duration_ = 7.83

		local var_371_0 = {
			zh = 6.533,
			ja = 7.833
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play319941090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_374_0 = 0
			local var_374_1 = 0.7

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_2 = arg_371_1:GetWordFromCfg(319941089)
				local var_374_3 = arg_371_1:FormatText(var_374_2.content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 28 <= 0 and var_374_1 or var_374_1 * (utf8.len(var_374_3) / 28)

				if (28 <= 0 and var_374_1 or var_374_1 * (utf8.len(var_374_3) / 28)) > 0 and var_374_1 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941089", "story_v_out_319941.awb") ~= 0 then
					local var_374_6 = manager.audio:GetVoiceLength("story_v_out_319941", "319941089", "story_v_out_319941.awb") / 1000

					if var_374_6 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_0
					end

					if var_374_2.prefab_name ~= "" and arg_371_1.actors_[var_374_2.prefab_name] ~= nil then
						local var_374_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_2.prefab_name].transform, "story_v_out_319941", "319941089", "story_v_out_319941.awb")

						arg_371_1:RecordAudio("319941089", var_374_7)
						arg_371_1:RecordAudio("319941089", var_374_7)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_319941", "319941089", "story_v_out_319941.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_319941", "319941089", "story_v_out_319941.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_8 and arg_371_1.time_ < var_374_0 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play319941090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 319941090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play319941091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["10075ui_story"]) and arg_375_1.var_.characterEffect10075ui_story == nil then
				arg_375_1.var_.characterEffect10075ui_story = arg_375_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["10075ui_story"]) then
				if arg_375_1.var_.characterEffect10075ui_story and not isNil(arg_375_1.actors_["10075ui_story"]) then
					arg_375_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_375_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_0)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["10075ui_story"]) and arg_375_1.var_.characterEffect10075ui_story then
				arg_375_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_375_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_378_1 = 0
			local var_378_2 = 0.95

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(319941090).content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 38 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 38)

				if (38 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 38)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_6 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_6 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_6

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_6 and arg_375_1.time_ < var_378_1 + var_378_6 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play319941091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 319941091
		arg_379_1.duration_ = 5.1

		local var_379_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play319941092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1084ui_story = arg_379_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).z)
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles = arg_379_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_379_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1084ui_story"].transform.position).z)
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1084ui_story"].transform.localEulerAngles = arg_379_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1084ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1084ui_story == nil then
				arg_379_1.var_.characterEffect1084ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1084ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1084ui_story then
				arg_379_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_382_4 = 0
			local var_382_5 = 0.35

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(319941091)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 14 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 14)

				if (14 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 14)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941091", "story_v_out_319941.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941091", "story_v_out_319941.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_out_319941", "319941091", "story_v_out_319941.awb")

						arg_379_1:RecordAudio("319941091", var_382_11)
						arg_379_1:RecordAudio("319941091", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_319941", "319941091", "story_v_out_319941.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_319941", "319941091", "story_v_out_319941.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play319941092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 319941092
		arg_383_1.duration_ = 7.87

		local var_383_0 = {
			zh = 4.6,
			ja = 7.866
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play319941093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10075ui_story"]) and arg_383_1.var_.characterEffect10075ui_story == nil then
				arg_383_1.var_.characterEffect10075ui_story = arg_383_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10075ui_story"]) then
				if arg_383_1.var_.characterEffect10075ui_story and not isNil(arg_383_1.actors_["10075ui_story"]) then
					arg_383_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10075ui_story"]) and arg_383_1.var_.characterEffect10075ui_story then
				arg_383_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_386_2 = arg_383_1.actors_["1084ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.characterEffect1084ui_story == nil then
				arg_383_1.var_.characterEffect1084ui_story = var_386_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_3 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.characterEffect1084ui_story and not isNil(var_386_2) then
					arg_383_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_3)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.characterEffect1084ui_story then
				arg_383_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_386_4 = 0
			local var_386_5 = 0.4

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_6 = arg_383_1:GetWordFromCfg(319941092)
				local var_386_7 = arg_383_1:FormatText(var_386_6.content)

				arg_383_1.text_.text = var_386_7

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 16 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 16)

				if (16 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 16)) > 0 and var_386_5 < var_386_9 then
					arg_383_1.talkMaxDuration = var_386_9

					if var_386_9 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_7
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941092", "story_v_out_319941.awb") ~= 0 then
					local var_386_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941092", "story_v_out_319941.awb") / 1000

					if var_386_10 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_4
					end

					if var_386_6.prefab_name ~= "" and arg_383_1.actors_[var_386_6.prefab_name] ~= nil then
						local var_386_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_6.prefab_name].transform, "story_v_out_319941", "319941092", "story_v_out_319941.awb")

						arg_383_1:RecordAudio("319941092", var_386_11)
						arg_383_1:RecordAudio("319941092", var_386_11)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_319941", "319941092", "story_v_out_319941.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_319941", "319941092", "story_v_out_319941.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_12 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_12

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_12 and arg_383_1.time_ < var_386_4 + var_386_12 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play319941093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 319941093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play319941094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["10075ui_story"]) and arg_387_1.var_.characterEffect10075ui_story == nil then
				arg_387_1.var_.characterEffect10075ui_story = arg_387_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["10075ui_story"]) then
				if arg_387_1.var_.characterEffect10075ui_story and not isNil(arg_387_1.actors_["10075ui_story"]) then
					arg_387_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_387_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["10075ui_story"]) and arg_387_1.var_.characterEffect10075ui_story then
				arg_387_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_387_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_390_1 = 0
			local var_390_2 = 1.425

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(319941093).content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 57 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 57)

				if (57 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 57)) > 0 and var_390_2 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_6 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_6 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_6

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_6 and arg_387_1.time_ < var_390_1 + var_390_6 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play319941094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 319941094
		arg_391_1.duration_ = 4.2

		local var_391_0 = {
			zh = 3.366,
			ja = 4.2
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play319941095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["10075ui_story"]) and arg_391_1.var_.characterEffect10075ui_story == nil then
				arg_391_1.var_.characterEffect10075ui_story = arg_391_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["10075ui_story"]) then
				if arg_391_1.var_.characterEffect10075ui_story and not isNil(arg_391_1.actors_["10075ui_story"]) then
					arg_391_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["10075ui_story"]) and arg_391_1.var_.characterEffect10075ui_story then
				arg_391_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_394_2 = 0
			local var_394_3 = 0.35

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(319941094)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 14 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 14)

				if (14 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 14)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941094", "story_v_out_319941.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_319941", "319941094", "story_v_out_319941.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_319941", "319941094", "story_v_out_319941.awb")

						arg_391_1:RecordAudio("319941094", var_394_9)
						arg_391_1:RecordAudio("319941094", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_319941", "319941094", "story_v_out_319941.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_319941", "319941094", "story_v_out_319941.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play319941095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 319941095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play319941096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1084ui_story = arg_395_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).z)
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles = arg_395_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1084ui_story"].transform.position).z)
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1084ui_story"].transform.localEulerAngles = arg_395_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["10075ui_story"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10075ui_story = var_398_1.localPosition
			end

			local var_398_2 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 then
				var_398_1.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_2)
				var_398_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_1.position).x, (manager.ui.mainCamera.transform.position - var_398_1.position).y, (manager.ui.mainCamera.transform.position - var_398_1.position).z)
				var_398_1.localEulerAngles.z = 0
				var_398_1.localEulerAngles.x = 0
				var_398_1.localEulerAngles = var_398_1.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 then
				var_398_1.localPosition = Vector3.New(0, 100, 0)
				var_398_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_398_1.position).x, (manager.ui.mainCamera.transform.position - var_398_1.position).y, (manager.ui.mainCamera.transform.position - var_398_1.position).z)
				var_398_1.localEulerAngles.z = 0
				var_398_1.localEulerAngles.x = 0
				var_398_1.localEulerAngles = var_398_1.localEulerAngles
			end

			local var_398_3 = 0
			local var_398_4 = 1.475

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_3 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_5 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(319941095).content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 59 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 59)

				if (59 <= 0 and var_398_4 or var_398_4 * (utf8.len(var_398_5) / 59)) > 0 and var_398_4 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_3 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_3
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_8 = math.max(var_398_4, arg_395_1.talkMaxDuration)

			if var_398_3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_3 + var_398_8 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_3) / var_398_8

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_3 + var_398_8 and arg_395_1.time_ < var_398_3 + var_398_8 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play319941096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 319941096
		arg_399_1.duration_ = 5.13

		local var_399_0 = {
			zh = 1.233,
			ja = 5.133
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play319941097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1095ui_story = arg_399_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).z)
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles = arg_399_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_399_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1095ui_story"].transform.position).z)
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1095ui_story"].transform.localEulerAngles = arg_399_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1095ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1095ui_story == nil then
				arg_399_1.var_.characterEffect1095ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect1095ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1095ui_story then
				arg_399_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_4 = 0
			local var_402_5 = 0.2

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(319941096)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_9 = 8 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 8)

				if (8 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 8)) > 0 and var_402_5 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941096", "story_v_out_319941.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_out_319941", "319941096", "story_v_out_319941.awb") / 1000

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end

					if var_402_6.prefab_name ~= "" and arg_399_1.actors_[var_402_6.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_6.prefab_name].transform, "story_v_out_319941", "319941096", "story_v_out_319941.awb")

						arg_399_1:RecordAudio("319941096", var_402_11)
						arg_399_1:RecordAudio("319941096", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_319941", "319941096", "story_v_out_319941.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_319941", "319941096", "story_v_out_319941.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_12 and arg_399_1.time_ < var_402_4 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play319941097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 319941097
		arg_403_1.duration_ = 2.77

		local var_403_0 = {
			zh = 1.999999999999,
			ja = 2.766
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play319941098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1095ui_story = arg_403_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).z)
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles = arg_403_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).z)
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles = arg_403_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1084ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1084ui_story = var_406_1.localPosition
			end

			local var_406_2 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 then
				var_406_1.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_2)
				var_406_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_1.position).x, (manager.ui.mainCamera.transform.position - var_406_1.position).y, (manager.ui.mainCamera.transform.position - var_406_1.position).z)
				var_406_1.localEulerAngles.z = 0
				var_406_1.localEulerAngles.x = 0
				var_406_1.localEulerAngles = var_406_1.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 then
				var_406_1.localPosition = Vector3.New(0, 100, 0)
				var_406_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_1.position).x, (manager.ui.mainCamera.transform.position - var_406_1.position).y, (manager.ui.mainCamera.transform.position - var_406_1.position).z)
				var_406_1.localEulerAngles.z = 0
				var_406_1.localEulerAngles.x = 0
				var_406_1.localEulerAngles = var_406_1.localEulerAngles
			end

			local var_406_3 = arg_403_1.actors_["10075ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10075ui_story = var_406_3.localPosition
			end

			local var_406_4 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				var_406_3.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_403_1.time_ - 0) / var_406_4)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				var_406_3.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			local var_406_5 = arg_403_1.actors_["10075ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect10075ui_story == nil then
				arg_403_1.var_.characterEffect10075ui_story = var_406_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_6 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_6 and not isNil(var_406_5) then
				if arg_403_1.var_.characterEffect10075ui_story and not isNil(var_406_5) then
					arg_403_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_6 and arg_403_1.time_ < 0 + var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect10075ui_story then
				arg_403_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_406_8 = 0
			local var_406_9 = 0.175

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_10 = arg_403_1:GetWordFromCfg(319941097)
				local var_406_11 = arg_403_1:FormatText(var_406_10.content)

				arg_403_1.text_.text = var_406_11

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_13 = 7 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 7)

				if (7 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 7)) > 0 and var_406_9 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_8
					end
				end

				arg_403_1.text_.text = var_406_11
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941097", "story_v_out_319941.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_out_319941", "319941097", "story_v_out_319941.awb") / 1000

					if var_406_14 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_8
					end

					if var_406_10.prefab_name ~= "" and arg_403_1.actors_[var_406_10.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_10.prefab_name].transform, "story_v_out_319941", "319941097", "story_v_out_319941.awb")

						arg_403_1:RecordAudio("319941097", var_406_15)
						arg_403_1:RecordAudio("319941097", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_319941", "319941097", "story_v_out_319941.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_319941", "319941097", "story_v_out_319941.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_16 = math.max(var_406_9, arg_403_1.talkMaxDuration)

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_16 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_8) / var_406_16

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_8 + var_406_16 and arg_403_1.time_ < var_406_8 + var_406_16 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play319941098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 319941098
		arg_407_1.duration_ = 4.2

		local var_407_0 = {
			zh = 4.2,
			ja = 4.133
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
			arg_407_1.auto_ = false
		end

		function arg_407_1.playNext_(arg_409_0)
			arg_407_1.onStoryFinished_()
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["10075ui_story"]) and arg_407_1.var_.characterEffect10075ui_story == nil then
				arg_407_1.var_.characterEffect10075ui_story = arg_407_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["10075ui_story"]) then
				if arg_407_1.var_.characterEffect10075ui_story and not isNil(arg_407_1.actors_["10075ui_story"]) then
					arg_407_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_407_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["10075ui_story"]) and arg_407_1.var_.characterEffect10075ui_story then
				arg_407_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_407_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_410_1 = arg_407_1.actors_["1084ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1084ui_story == nil then
				arg_407_1.var_.characterEffect1084ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect1084ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1084ui_story then
				arg_407_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_410_4 = arg_407_1.actors_["1084ui_story"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1084ui_story = var_410_4.localPosition
			end

			local var_410_5 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_5 then
				var_410_4.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_407_1.time_ - 0) / var_410_5)
				var_410_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_4.position).x, (manager.ui.mainCamera.transform.position - var_410_4.position).y, (manager.ui.mainCamera.transform.position - var_410_4.position).z)
				var_410_4.localEulerAngles.z = 0
				var_410_4.localEulerAngles.x = 0
				var_410_4.localEulerAngles = var_410_4.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_5 and arg_407_1.time_ < 0 + var_410_5 + arg_410_0 then
				var_410_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_410_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_4.position).x, (manager.ui.mainCamera.transform.position - var_410_4.position).y, (manager.ui.mainCamera.transform.position - var_410_4.position).z)
				var_410_4.localEulerAngles.z = 0
				var_410_4.localEulerAngles.x = 0
				var_410_4.localEulerAngles = var_410_4.localEulerAngles
			end

			local var_410_6 = 0
			local var_410_7 = 0.375

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:GetWordFromCfg(319941098)
				local var_410_9 = arg_407_1:FormatText(var_410_8.content)

				arg_407_1.text_.text = var_410_9

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 15 <= 0 and var_410_7 or var_410_7 * (utf8.len(var_410_9) / 15)

				if (15 <= 0 and var_410_7 or var_410_7 * (utf8.len(var_410_9) / 15)) > 0 and var_410_7 < var_410_11 then
					arg_407_1.talkMaxDuration = var_410_11

					if var_410_11 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_11 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_9
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319941", "319941098", "story_v_out_319941.awb") ~= 0 then
					local var_410_12 = manager.audio:GetVoiceLength("story_v_out_319941", "319941098", "story_v_out_319941.awb") / 1000

					if var_410_12 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_12 + var_410_6
					end

					if var_410_8.prefab_name ~= "" and arg_407_1.actors_[var_410_8.prefab_name] ~= nil then
						local var_410_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_8.prefab_name].transform, "story_v_out_319941", "319941098", "story_v_out_319941.awb")

						arg_407_1:RecordAudio("319941098", var_410_13)
						arg_407_1:RecordAudio("319941098", var_410_13)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_319941", "319941098", "story_v_out_319941.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_319941", "319941098", "story_v_out_319941.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_14 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_14 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_14

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_14 and arg_407_1.time_ < var_410_6 + var_410_14 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
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

		arg_407_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/ST70"
	},
	voices = {
		"story_v_out_319941.awb"
	}
}
