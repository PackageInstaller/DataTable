return {
	Play421091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421091001
		arg_1_1.duration_ = 5.47

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D12a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D12a")
				var_4_0.name = "D12a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D12a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D12a

				arg_1_1.bgs_.D12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D12a" then
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

			local var_4_9 = "10102ui_story"

			if arg_1_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10102ui_story"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10102ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_1_1.time_ - 1.86666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_14 and arg_1_1.time_ < 1.86666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.985, -6.275)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10102ui_story"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10102ui_story == nil then
				arg_1_1.var_.characterEffect10102ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10102ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_16 and arg_1_1.time_ < 1.86666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10102ui_story then
				arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 2
			local var_4_26 = 0.425

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(421091001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 17 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 17)

				if (17 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 17)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091001", "story_v_out_421091.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_421091", "421091001", "story_v_out_421091.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_421091", "421091001", "story_v_out_421091.awb")

						arg_1_1:RecordAudio("421091001", var_4_33)
						arg_1_1:RecordAudio("421091001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421091", "421091001", "story_v_out_421091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421091", "421091001", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play421091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10102ui_story"]) and arg_9_1.var_.characterEffect10102ui_story == nil then
				arg_9_1.var_.characterEffect10102ui_story = arg_9_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10102ui_story"]) then
				if arg_9_1.var_.characterEffect10102ui_story and not isNil(arg_9_1.actors_["10102ui_story"]) then
					arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10102ui_story"]) and arg_9_1.var_.characterEffect10102ui_story then
				arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(421091002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 15 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 15)

				if (15 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 15)) > 0 and var_12_2 < var_12_5 then
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
	Play421091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421091003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 2.733,
			ja = 3.433
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
				arg_13_0:Play421091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10102ui_story = arg_13_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).z)
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles = arg_13_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_13_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10102ui_story"].transform.position).z)
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10102ui_story"].transform.localEulerAngles = arg_13_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["10102ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10102ui_story == nil then
				arg_13_1.var_.characterEffect10102ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10102ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10102ui_story then
				arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_4 = 0
			local var_16_5 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(421091003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 16 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 16)

				if (16 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 16)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091003", "story_v_out_421091.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091003", "story_v_out_421091.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_421091", "421091003", "story_v_out_421091.awb")

						arg_13_1:RecordAudio("421091003", var_16_11)
						arg_13_1:RecordAudio("421091003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421091", "421091003", "story_v_out_421091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421091", "421091003", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
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
	Play421091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = arg_17_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_20_1 = 0
			local var_20_2 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(421091004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 18)

				if (18 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 18)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421091005
		arg_21_1.duration_ = 5.2

		local var_21_0 = {
			zh = 3.6,
			ja = 5.2
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
				arg_21_0:Play421091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10102ui_story = arg_21_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).z)
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles = arg_21_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10102ui_story"].transform.position).z)
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10102ui_story"].transform.localEulerAngles = arg_21_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_24_1 = "1047ui_story"

			if arg_21_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_21_1.stage_.transform)

				var_24_2.name = var_24_1
				var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_1] = var_24_2

				local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

				var_24_3.enabled = true

				local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

				if var_24_4 then
					var_24_4:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_3.transform, false)

				arg_21_1.var_[var_24_1 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_1 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_1 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_5 = arg_21_1.actors_["1047ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = var_24_5.localPosition
			end

			local var_24_6 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_21_1.time_ - 0) / var_24_6)
				var_24_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_5.position).x, (manager.ui.mainCamera.transform.position - var_24_5.position).y, (manager.ui.mainCamera.transform.position - var_24_5.position).z)
				var_24_5.localEulerAngles.z = 0
				var_24_5.localEulerAngles.x = 0
				var_24_5.localEulerAngles = var_24_5.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.13, -6.2)
				var_24_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_5.position).x, (manager.ui.mainCamera.transform.position - var_24_5.position).y, (manager.ui.mainCamera.transform.position - var_24_5.position).z)
				var_24_5.localEulerAngles.z = 0
				var_24_5.localEulerAngles.x = 0
				var_24_5.localEulerAngles = var_24_5.localEulerAngles
			end

			local var_24_7 = arg_21_1.actors_["1047ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_8 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_8 and not isNil(var_24_7) then
				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_7) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_8 and arg_21_1.time_ < 0 + var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_10 = 0
			local var_24_11 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(421091005)
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091005", "story_v_out_421091.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_421091", "421091005", "story_v_out_421091.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_421091", "421091005", "story_v_out_421091.awb")

						arg_21_1:RecordAudio("421091005", var_24_17)
						arg_21_1:RecordAudio("421091005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421091", "421091005", "story_v_out_421091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421091", "421091005", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421091006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = arg_25_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1047ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1047ui_story == nil then
				arg_25_1.var_.characterEffect1047ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1047ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1047ui_story then
				arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.75

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(421091006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 30 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 30)

				if (30 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 30)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421091007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(421091007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 20 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 20)

				if (20 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 20)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play421091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421091008
		arg_33_1.duration_ = 4.03

		local var_33_0 = {
			zh = 2.033,
			ja = 4.033
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
				arg_33_0:Play421091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1047ui_story = arg_33_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).z)
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles = arg_33_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_33_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).z)
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles = arg_33_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1047ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1047ui_story == nil then
				arg_33_1.var_.characterEffect1047ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1047ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1047ui_story then
				arg_33_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_36_4 = 0
			local var_36_5 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(421091008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 10 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 10)

				if (10 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 10)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091008", "story_v_out_421091.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091008", "story_v_out_421091.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_421091", "421091008", "story_v_out_421091.awb")

						arg_33_1:RecordAudio("421091008", var_36_11)
						arg_33_1:RecordAudio("421091008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421091", "421091008", "story_v_out_421091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421091", "421091008", "story_v_out_421091.awb")
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
				actorName = "1047ui_story",
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
	Play421091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421091009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = arg_37_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(arg_37_1.actors_["1047ui_story"]) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_40_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_3 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_3

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_3
						arg_37_1.bgmTxt2_.text = var_40_3
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_40_4 = 0
			local var_40_5 = 0.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_6 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(421091009).content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 4 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 4)

				if (4 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 4)) > 0 and var_40_5 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_9 and arg_37_1.time_ < var_40_4 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play421091010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 421091010
		arg_42_1.duration_ = 9

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play421091011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 2 < arg_42_1.time_ and arg_42_1.time_ <= 2 + arg_45_0 then
				local var_45_0 = arg_42_1.bgs_.D12a

				arg_42_1.bgs_.D12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_1 = var_45_0:GetComponent("SpriteRenderer")

				if var_45_1 and var_45_1.sprite then
					local var_45_2 = 2 * (var_45_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_0.transform.localScale = Vector3.New(var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "D12a" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_3 = 4

			if 4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 0.3 and arg_42_1.time_ < var_45_3 + 0.3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_4 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_5 = 2

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_5 then
				local var_45_6 = Color.New(0, 0, 0)

				var_45_6.a = Mathf.Lerp(0, 1, (arg_42_1.time_ - var_45_4) / var_45_5)
				arg_42_1.mask_.color = var_45_6
			end

			if arg_42_1.time_ >= var_45_4 + var_45_5 and arg_42_1.time_ < var_45_4 + var_45_5 + arg_45_0 then
				local var_45_7 = Color.New(0, 0, 0)

				var_45_7.a = 1
				arg_42_1.mask_.color = var_45_7
			end

			local var_45_8 = 2

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_9 = 2

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_9 then
				local var_45_10 = Color.New(0, 0, 0)

				var_45_10.a = Mathf.Lerp(1, 0, (arg_42_1.time_ - var_45_8) / var_45_9)
				arg_42_1.mask_.color = var_45_10
			end

			if arg_42_1.time_ >= var_45_8 + var_45_9 and arg_42_1.time_ < var_45_8 + var_45_9 + arg_45_0 then
				local var_45_11 = Color.New(0, 0, 0)

				arg_42_1.mask_.enabled = false
				var_45_11.a = 0
				arg_42_1.mask_.color = var_45_11
			end

			local var_45_12 = arg_42_1.actors_["1047ui_story"].transform

			if 1.96599999815226 < arg_42_1.time_ and arg_42_1.time_ <= 1.96599999815226 + arg_45_0 then
				arg_42_1.var_.moveOldPos1047ui_story = var_45_12.localPosition
			end

			local var_45_13 = 0.001

			if 1.96599999815226 <= arg_42_1.time_ and arg_42_1.time_ < 1.96599999815226 + var_45_13 then
				var_45_12.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 1.96599999815226) / var_45_13)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles
			end

			if arg_42_1.time_ >= 1.96599999815226 + var_45_13 and arg_42_1.time_ < 1.96599999815226 + var_45_13 + arg_45_0 then
				var_45_12.localPosition = Vector3.New(0, 100, 0)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_45_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_16 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_16

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_16
						arg_42_1.bgmTxt2_.text = var_45_16
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_42_1.time_ and arg_42_1.time_ <= 1.53333333333333 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_45_19 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_19 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_19

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_19
						arg_42_1.bgmTxt2_.text = var_45_19
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_42_1.time_ and arg_42_1.time_ <= 1.53333333333333 + arg_45_0 then
				arg_42_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 0.1 < arg_42_1.time_ and arg_42_1.time_ <= 0.1 + arg_45_0 then
				arg_42_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_22 = 4
			local var_45_23 = 1.275

			if 4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_22 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_24 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_24:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_42_1.dialogCg_.alpha = arg_48_0
				end))
				var_45_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_25 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(421091010).content)

				arg_42_1.text_.text = var_45_25

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_27 = 51 <= 0 and var_45_23 or var_45_23 * (utf8.len(var_45_25) / 51)

				if (51 <= 0 and var_45_23 or var_45_23 * (utf8.len(var_45_25) / 51)) > 0 and var_45_23 < var_45_27 then
					arg_42_1.talkMaxDuration = var_45_27
					var_45_22 = var_45_22 + 0.3

					if var_45_27 + var_45_22 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_27 + var_45_22
					end
				end

				arg_42_1.text_.text = var_45_25
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_28 = var_45_22 + 0.3
			local var_45_29 = math.max(var_45_23, arg_42_1.talkMaxDuration)

			if var_45_22 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_29 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_28) / var_45_29

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_28 + var_45_29 and arg_42_1.time_ < var_45_28 + var_45_29 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play421091011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 421091011
		arg_50_1.duration_ = 3.2

		local var_50_0 = {
			zh = 2.5,
			ja = 3.2
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play421091012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10102ui_story = arg_50_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).z)
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles = arg_50_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_50_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10102ui_story"].transform.position).z)
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10102ui_story"].transform.localEulerAngles = arg_50_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["10102ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect10102ui_story == nil then
				arg_50_1.var_.characterEffect10102ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect10102ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect10102ui_story then
				arg_50_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_4 = 0
			local var_53_5 = 0.325

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(421091011)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 13 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 13)

				if (13 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 13)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091011", "story_v_out_421091.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091011", "story_v_out_421091.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_421091", "421091011", "story_v_out_421091.awb")

						arg_50_1:RecordAudio("421091011", var_53_11)
						arg_50_1:RecordAudio("421091011", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_421091", "421091011", "story_v_out_421091.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_421091", "421091011", "story_v_out_421091.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play421091012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 421091012
		arg_54_1.duration_ = 4.27

		local var_54_0 = {
			zh = 2.466,
			ja = 4.266
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play421091013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_57_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_54_1.stage_.transform)

				var_57_0.name = "10143ui_story"
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["10143ui_story"] = var_57_0

				local var_57_1 = var_57_0:GetComponentInChildren(typeof(CharacterEffect))

				var_57_1.enabled = true

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end

				arg_54_1:ShowWeapon(var_57_1.transform, false)

				arg_54_1.var_["10143ui_story" .. "Animator"] = var_57_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_54_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_54_1.var_["10143ui_story" .. "LipSync"] = var_57_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_57_3 = arg_54_1.actors_["10143ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos10143ui_story = var_57_3.localPosition
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_3.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_54_1.time_ - 0) / var_57_4)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_3.localPosition = Vector3.New(0.78, -1.06, -6)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			local var_57_5 = arg_54_1.actors_["10143ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect10143ui_story == nil then
				arg_54_1.var_.characterEffect10143ui_story = var_57_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_6 and not isNil(var_57_5) then
				if arg_54_1.var_.characterEffect10143ui_story and not isNil(var_57_5) then
					arg_54_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_6 and arg_54_1.time_ < 0 + var_57_6 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect10143ui_story then
				arg_54_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_57_8 = arg_54_1.actors_["10102ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.characterEffect10102ui_story == nil then
				arg_54_1.var_.characterEffect10102ui_story = var_57_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_9 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_9 and not isNil(var_57_8) then
				if arg_54_1.var_.characterEffect10102ui_story and not isNil(var_57_8) then
					arg_54_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_9)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_9 and arg_54_1.time_ < 0 + var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.characterEffect10102ui_story then
				arg_54_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_10 = 0
			local var_57_11 = 0.35

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_12 = arg_54_1:GetWordFromCfg(421091012)
				local var_57_13 = arg_54_1:FormatText(var_57_12.content)

				arg_54_1.text_.text = var_57_13

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 14 <= 0 and var_57_11 or var_57_11 * (utf8.len(var_57_13) / 14)

				if (14 <= 0 and var_57_11 or var_57_11 * (utf8.len(var_57_13) / 14)) > 0 and var_57_11 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_13
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091012", "story_v_out_421091.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_421091", "421091012", "story_v_out_421091.awb") / 1000

					if var_57_16 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_10
					end

					if var_57_12.prefab_name ~= "" and arg_54_1.actors_[var_57_12.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_12.prefab_name].transform, "story_v_out_421091", "421091012", "story_v_out_421091.awb")

						arg_54_1:RecordAudio("421091012", var_57_17)
						arg_54_1:RecordAudio("421091012", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_421091", "421091012", "story_v_out_421091.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_421091", "421091012", "story_v_out_421091.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_18 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_18

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_18 and arg_54_1.time_ < var_57_10 + var_57_18 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play421091013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 421091013
		arg_58_1.duration_ = 2.87

		local var_58_0 = {
			zh = 2.7,
			ja = 2.866
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play421091014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1047ui_story = arg_58_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).z)
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles = arg_58_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_58_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1047ui_story"].transform.position).z)
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1047ui_story"].transform.localEulerAngles = arg_58_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["10102ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10102ui_story = var_61_1.localPosition
			end

			local var_61_2 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 then
				var_61_1.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_2)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 then
				var_61_1.localPosition = Vector3.New(0, 100, 0)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			local var_61_3 = arg_58_1.actors_["1047ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect1047ui_story == nil then
				arg_58_1.var_.characterEffect1047ui_story = var_61_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_4 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 and not isNil(var_61_3) then
				if arg_58_1.var_.characterEffect1047ui_story and not isNil(var_61_3) then
					arg_58_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect1047ui_story then
				arg_58_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_61_6 = arg_58_1.actors_["10143ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.characterEffect10143ui_story == nil then
				arg_58_1.var_.characterEffect10143ui_story = var_61_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_7 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 and not isNil(var_61_6) then
				if arg_58_1.var_.characterEffect10143ui_story and not isNil(var_61_6) then
					arg_58_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_58_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_7)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.characterEffect10143ui_story then
				arg_58_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_58_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_8 = 0
			local var_61_9 = 0.375

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:GetWordFromCfg(421091013)
				local var_61_11 = arg_58_1:FormatText(var_61_10.content)

				arg_58_1.text_.text = var_61_11

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 15 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 15)

				if (15 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 15)) > 0 and var_61_9 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_11
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091013", "story_v_out_421091.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_421091", "421091013", "story_v_out_421091.awb") / 1000

					if var_61_14 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_8
					end

					if var_61_10.prefab_name ~= "" and arg_58_1.actors_[var_61_10.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_10.prefab_name].transform, "story_v_out_421091", "421091013", "story_v_out_421091.awb")

						arg_58_1:RecordAudio("421091013", var_61_15)
						arg_58_1:RecordAudio("421091013", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_421091", "421091013", "story_v_out_421091.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_421091", "421091013", "story_v_out_421091.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play421091014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 421091014
		arg_62_1.duration_ = 4.3

		local var_62_0 = {
			zh = 3,
			ja = 4.3
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play421091015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10143ui_story = arg_62_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).z)
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles = arg_62_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_62_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10143ui_story"].transform.position).z)
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["10143ui_story"].transform.localEulerAngles = arg_62_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["10143ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect10143ui_story == nil then
				arg_62_1.var_.characterEffect10143ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect10143ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect10143ui_story then
				arg_62_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["1047ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1047ui_story == nil then
				arg_62_1.var_.characterEffect1047ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_5 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 and not isNil(var_65_4) then
				if arg_62_1.var_.characterEffect1047ui_story and not isNil(var_65_4) then
					arg_62_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_5)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1047ui_story then
				arg_62_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_65_6 = 0
			local var_65_7 = 0.425

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_8 = arg_62_1:GetWordFromCfg(421091014)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 17 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 17)

				if (17 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 17)) > 0 and var_65_7 < var_65_11 then
					arg_62_1.talkMaxDuration = var_65_11

					if var_65_11 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091014", "story_v_out_421091.awb") ~= 0 then
					local var_65_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091014", "story_v_out_421091.awb") / 1000

					if var_65_12 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_6
					end

					if var_65_8.prefab_name ~= "" and arg_62_1.actors_[var_65_8.prefab_name] ~= nil then
						local var_65_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_8.prefab_name].transform, "story_v_out_421091", "421091014", "story_v_out_421091.awb")

						arg_62_1:RecordAudio("421091014", var_65_13)
						arg_62_1:RecordAudio("421091014", var_65_13)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_421091", "421091014", "story_v_out_421091.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_421091", "421091014", "story_v_out_421091.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play421091015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 421091015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play421091016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10143ui_story = arg_66_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).z)
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles = arg_66_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10143ui_story"].transform.position).z)
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10143ui_story"].transform.localEulerAngles = arg_66_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1047ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1047ui_story = var_69_1.localPosition
			end

			local var_69_2 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_2)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0, 100, 0)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			local var_69_3 = 0
			local var_69_4 = 0.85

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(421091015).content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 34 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 34)

				if (34 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 34)) > 0 and var_69_4 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_8 and arg_66_1.time_ < var_69_3 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play421091016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 421091016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play421091017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.85

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(421091016).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 34 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 34)

				if (34 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 34)) > 0 and var_73_0 < var_73_3 then
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
	Play421091017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 421091017
		arg_74_1.duration_ = 2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play421091018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10102ui_story = arg_74_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).z)
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles = arg_74_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_74_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10102ui_story"].transform.position).z)
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10102ui_story"].transform.localEulerAngles = arg_74_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_77_1 = arg_74_1.actors_["10102ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect10102ui_story == nil then
				arg_74_1.var_.characterEffect10102ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 and not isNil(var_77_1) then
				if arg_74_1.var_.characterEffect10102ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect10102ui_story then
				arg_74_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_4 = 0
			local var_77_5 = 0.175

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(421091017)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 7 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 7)

				if (7 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 7)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091017", "story_v_out_421091.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091017", "story_v_out_421091.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_421091", "421091017", "story_v_out_421091.awb")

						arg_74_1:RecordAudio("421091017", var_77_11)
						arg_74_1:RecordAudio("421091017", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_421091", "421091017", "story_v_out_421091.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_421091", "421091017", "story_v_out_421091.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play421091018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 421091018
		arg_78_1.duration_ = 7.1

		local var_78_0 = {
			zh = 3.266,
			ja = 7.1
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
				arg_78_0:Play421091019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10102ui_story = arg_78_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).z)
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles = arg_78_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10102ui_story"].transform.position).z)
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10102ui_story"].transform.localEulerAngles = arg_78_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["1047ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1047ui_story = var_81_1.localPosition
			end

			local var_81_2 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_78_1.time_ - 0) / var_81_2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			local var_81_3 = arg_78_1.actors_["1047ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1047ui_story == nil then
				arg_78_1.var_.characterEffect1047ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1047ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1047ui_story then
				arg_78_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_81_6 = arg_78_1.actors_["10102ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect10102ui_story == nil then
				arg_78_1.var_.characterEffect10102ui_story = var_81_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_7 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 and not isNil(var_81_6) then
				if arg_78_1.var_.characterEffect10102ui_story and not isNil(var_81_6) then
					arg_78_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_7)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect10102ui_story then
				arg_78_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_81_8 = 0
			local var_81_9 = 0.375

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_10 = arg_78_1:GetWordFromCfg(421091018)
				local var_81_11 = arg_78_1:FormatText(var_81_10.content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 15 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 15)

				if (15 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 15)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091018", "story_v_out_421091.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_421091", "421091018", "story_v_out_421091.awb") / 1000

					if var_81_14 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_8
					end

					if var_81_10.prefab_name ~= "" and arg_78_1.actors_[var_81_10.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_10.prefab_name].transform, "story_v_out_421091", "421091018", "story_v_out_421091.awb")

						arg_78_1:RecordAudio("421091018", var_81_15)
						arg_78_1:RecordAudio("421091018", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_421091", "421091018", "story_v_out_421091.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_421091", "421091018", "story_v_out_421091.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_16 and arg_78_1.time_ < var_81_8 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play421091019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 421091019
		arg_82_1.duration_ = 6.43

		local var_82_0 = {
			zh = 5.566,
			ja = 6.433
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play421091020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10143ui_story = arg_82_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).z)
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles = arg_82_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_82_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10143ui_story"].transform.position).z)
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10143ui_story"].transform.localEulerAngles = arg_82_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_85_1 = arg_82_1.actors_["10143ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect10143ui_story == nil then
				arg_82_1.var_.characterEffect10143ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect10143ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect10143ui_story then
				arg_82_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1047ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1047ui_story == nil then
				arg_82_1.var_.characterEffect1047ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_5 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_5 and not isNil(var_85_4) then
				if arg_82_1.var_.characterEffect1047ui_story and not isNil(var_85_4) then
					arg_82_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_5)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_5 and arg_82_1.time_ < 0 + var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1047ui_story then
				arg_82_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_85_6 = 0
			local var_85_7 = 0.65

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(421091019)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 26 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 26)

				if (26 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 26)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091019", "story_v_out_421091.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091019", "story_v_out_421091.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_421091", "421091019", "story_v_out_421091.awb")

						arg_82_1:RecordAudio("421091019", var_85_13)
						arg_82_1:RecordAudio("421091019", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_421091", "421091019", "story_v_out_421091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_421091", "421091019", "story_v_out_421091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play421091020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 421091020
		arg_86_1.duration_ = 4.77

		local var_86_0 = {
			zh = 4.766,
			ja = 1.833
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
				arg_86_0:Play421091021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10143ui_story"]) and arg_86_1.var_.characterEffect10143ui_story == nil then
				arg_86_1.var_.characterEffect10143ui_story = arg_86_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10143ui_story"]) then
				if arg_86_1.var_.characterEffect10143ui_story and not isNil(arg_86_1.actors_["10143ui_story"]) then
					arg_86_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10143ui_story"]) and arg_86_1.var_.characterEffect10143ui_story then
				arg_86_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_89_1 = arg_86_1.actors_["1047ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1047ui_story == nil then
				arg_86_1.var_.characterEffect1047ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect1047ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1047ui_story then
				arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_89_4 = 0
			local var_89_5 = 0.75

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(421091020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 30 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 30)

				if (30 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 30)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091020", "story_v_out_421091.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091020", "story_v_out_421091.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_421091", "421091020", "story_v_out_421091.awb")

						arg_86_1:RecordAudio("421091020", var_89_11)
						arg_86_1:RecordAudio("421091020", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_421091", "421091020", "story_v_out_421091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_421091", "421091020", "story_v_out_421091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play421091021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 421091021
		arg_90_1.duration_ = 10.47

		local var_90_0 = {
			zh = 8.433,
			ja = 10.466
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play421091022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_93_0 = 0
			local var_93_1 = 0.975

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(421091021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 39 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 39)

				if (39 <= 0 and var_93_1 or var_93_1 * (utf8.len(var_93_3) / 39)) > 0 and var_93_1 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091021", "story_v_out_421091.awb") ~= 0 then
					local var_93_6 = manager.audio:GetVoiceLength("story_v_out_421091", "421091021", "story_v_out_421091.awb") / 1000

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end

					if var_93_2.prefab_name ~= "" and arg_90_1.actors_[var_93_2.prefab_name] ~= nil then
						local var_93_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_2.prefab_name].transform, "story_v_out_421091", "421091021", "story_v_out_421091.awb")

						arg_90_1:RecordAudio("421091021", var_93_7)
						arg_90_1:RecordAudio("421091021", var_93_7)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_421091", "421091021", "story_v_out_421091.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_421091", "421091021", "story_v_out_421091.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play421091022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 421091022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play421091023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) and arg_94_1.var_.characterEffect1047ui_story == nil then
				arg_94_1.var_.characterEffect1047ui_story = arg_94_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) then
				if arg_94_1.var_.characterEffect1047ui_story and not isNil(arg_94_1.actors_["1047ui_story"]) then
					arg_94_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) and arg_94_1.var_.characterEffect1047ui_story then
				arg_94_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_97_1 = 0
			local var_97_2 = 0.5

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(421091022).content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 20 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 20)

				if (20 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 20)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_6 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_6 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_6

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_6 and arg_94_1.time_ < var_97_1 + var_97_6 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play421091023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 421091023
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play421091024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10143ui_story = arg_98_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).z)
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles = arg_98_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_98_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10143ui_story"].transform.position).z)
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10143ui_story"].transform.localEulerAngles = arg_98_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["10143ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10143ui_story == nil then
				arg_98_1.var_.characterEffect10143ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect10143ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10143ui_story then
				arg_98_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_101_4 = 0
			local var_101_5 = 0.075

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(421091023)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 3 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 3)

				if (3 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 3)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091023", "story_v_out_421091.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091023", "story_v_out_421091.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_421091", "421091023", "story_v_out_421091.awb")

						arg_98_1:RecordAudio("421091023", var_101_11)
						arg_98_1:RecordAudio("421091023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_421091", "421091023", "story_v_out_421091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_421091", "421091023", "story_v_out_421091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play421091024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 421091024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play421091025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10143ui_story"]) and arg_102_1.var_.characterEffect10143ui_story == nil then
				arg_102_1.var_.characterEffect10143ui_story = arg_102_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10143ui_story"]) then
				if arg_102_1.var_.characterEffect10143ui_story and not isNil(arg_102_1.actors_["10143ui_story"]) then
					arg_102_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10143ui_story"]) and arg_102_1.var_.characterEffect10143ui_story then
				arg_102_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.85

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(421091024).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 34 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 34)

				if (34 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 34)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play421091025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 421091025
		arg_106_1.duration_ = 4.3

		local var_106_0 = {
			zh = 4.3,
			ja = 3.8
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
				arg_106_0:Play421091026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1047ui_story = arg_106_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).z)
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles = arg_106_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_106_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1047ui_story"].transform.position).z)
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1047ui_story"].transform.localEulerAngles = arg_106_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1047ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1047ui_story == nil then
				arg_106_1.var_.characterEffect1047ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1047ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1047ui_story then
				arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_4 = 0
			local var_109_5 = 0.475

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(421091025)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 19 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 19)

				if (19 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 19)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091025", "story_v_out_421091.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091025", "story_v_out_421091.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_421091", "421091025", "story_v_out_421091.awb")

						arg_106_1:RecordAudio("421091025", var_109_11)
						arg_106_1:RecordAudio("421091025", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_421091", "421091025", "story_v_out_421091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_421091", "421091025", "story_v_out_421091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play421091026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 421091026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play421091027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) and arg_110_1.var_.characterEffect1047ui_story == nil then
				arg_110_1.var_.characterEffect1047ui_story = arg_110_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) then
				if arg_110_1.var_.characterEffect1047ui_story and not isNil(arg_110_1.actors_["1047ui_story"]) then
					arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) and arg_110_1.var_.characterEffect1047ui_story then
				arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.475

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(421091026).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)

				if (19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play421091027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 421091027
		arg_114_1.duration_ = 11.43

		local var_114_0 = {
			zh = 8.3,
			ja = 11.433
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play421091028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10143ui_story = arg_114_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).z)
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles = arg_114_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_114_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10143ui_story"].transform.position).z)
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10143ui_story"].transform.localEulerAngles = arg_114_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["10143ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect10143ui_story == nil then
				arg_114_1.var_.characterEffect10143ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect10143ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect10143ui_story then
				arg_114_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			local var_117_4 = 0
			local var_117_5 = 0.95

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(421091027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 38 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 38)

				if (38 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 38)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091027", "story_v_out_421091.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091027", "story_v_out_421091.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_421091", "421091027", "story_v_out_421091.awb")

						arg_114_1:RecordAudio("421091027", var_117_11)
						arg_114_1:RecordAudio("421091027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_421091", "421091027", "story_v_out_421091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_421091", "421091027", "story_v_out_421091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play421091028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 421091028
		arg_118_1.duration_ = 15.1

		local var_118_0 = {
			zh = 7.333,
			ja = 15.1
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play421091029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1047ui_story = arg_118_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).z)
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles = arg_118_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_118_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1047ui_story"].transform.position).z)
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1047ui_story"].transform.localEulerAngles = arg_118_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1047ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1047ui_story == nil then
				arg_118_1.var_.characterEffect1047ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1047ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1047ui_story then
				arg_118_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["10143ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10143ui_story == nil then
				arg_118_1.var_.characterEffect10143ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_5 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_5 and not isNil(var_121_4) then
				if arg_118_1.var_.characterEffect10143ui_story and not isNil(var_121_4) then
					arg_118_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_5)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_5 and arg_118_1.time_ < 0 + var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10143ui_story then
				arg_118_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_121_6 = 0
			local var_121_7 = 0.9

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(421091028)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 36 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 36)

				if (36 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 36)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091028", "story_v_out_421091.awb") ~= 0 then
					local var_121_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091028", "story_v_out_421091.awb") / 1000

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end

					if var_121_8.prefab_name ~= "" and arg_118_1.actors_[var_121_8.prefab_name] ~= nil then
						local var_121_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_8.prefab_name].transform, "story_v_out_421091", "421091028", "story_v_out_421091.awb")

						arg_118_1:RecordAudio("421091028", var_121_13)
						arg_118_1:RecordAudio("421091028", var_121_13)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_421091", "421091028", "story_v_out_421091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_421091", "421091028", "story_v_out_421091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play421091029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 421091029
		arg_122_1.duration_ = 7.83

		local var_122_0 = {
			zh = 6.5,
			ja = 7.833
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play421091030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1047ui_story = arg_122_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).z)
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles = arg_122_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_122_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1047ui_story"].transform.position).z)
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1047ui_story"].transform.localEulerAngles = arg_122_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_125_1 = 0
			local var_125_2 = 0.75

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(421091029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 30 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 30)

				if (30 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 30)) > 0 and var_125_2 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091029", "story_v_out_421091.awb") ~= 0 then
					local var_125_7 = manager.audio:GetVoiceLength("story_v_out_421091", "421091029", "story_v_out_421091.awb") / 1000

					if var_125_7 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_1
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_421091", "421091029", "story_v_out_421091.awb")

						arg_122_1:RecordAudio("421091029", var_125_8)
						arg_122_1:RecordAudio("421091029", var_125_8)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_421091", "421091029", "story_v_out_421091.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_421091", "421091029", "story_v_out_421091.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_9 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_9

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_9 and arg_122_1.time_ < var_125_1 + var_125_9 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play421091030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 421091030
		arg_126_1.duration_ = 7.63

		local var_126_0 = {
			zh = 7.633,
			ja = 7.366
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play421091031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10143ui_story = arg_126_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).z)
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles = arg_126_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_126_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10143ui_story"].transform.position).z)
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10143ui_story"].transform.localEulerAngles = arg_126_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["10143ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect10143ui_story == nil then
				arg_126_1.var_.characterEffect10143ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect10143ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect10143ui_story then
				arg_126_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["1047ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1047ui_story == nil then
				arg_126_1.var_.characterEffect1047ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_5 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_5 and not isNil(var_129_4) then
				if arg_126_1.var_.characterEffect1047ui_story and not isNil(var_129_4) then
					arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_5)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_5 and arg_126_1.time_ < 0 + var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1047ui_story then
				arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_129_6 = 0
			local var_129_7 = 0.875

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_8 = arg_126_1:GetWordFromCfg(421091030)
				local var_129_9 = arg_126_1:FormatText(var_129_8.content)

				arg_126_1.text_.text = var_129_9

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 35 <= 0 and var_129_7 or var_129_7 * (utf8.len(var_129_9) / 35)

				if (35 <= 0 and var_129_7 or var_129_7 * (utf8.len(var_129_9) / 35)) > 0 and var_129_7 < var_129_11 then
					arg_126_1.talkMaxDuration = var_129_11

					if var_129_11 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_9
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091030", "story_v_out_421091.awb") ~= 0 then
					local var_129_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091030", "story_v_out_421091.awb") / 1000

					if var_129_12 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_12 + var_129_6
					end

					if var_129_8.prefab_name ~= "" and arg_126_1.actors_[var_129_8.prefab_name] ~= nil then
						local var_129_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_8.prefab_name].transform, "story_v_out_421091", "421091030", "story_v_out_421091.awb")

						arg_126_1:RecordAudio("421091030", var_129_13)
						arg_126_1:RecordAudio("421091030", var_129_13)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_421091", "421091030", "story_v_out_421091.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_421091", "421091030", "story_v_out_421091.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play421091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 421091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play421091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10143ui_story = arg_130_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).z)
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles = arg_130_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10143ui_story"].transform.position).z)
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10143ui_story"].transform.localEulerAngles = arg_130_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1047ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1047ui_story = var_133_1.localPosition
			end

			local var_133_2 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 then
				var_133_1.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_2)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 then
				var_133_1.localPosition = Vector3.New(0, 100, 0)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles
			end

			local var_133_3 = 0
			local var_133_4 = 0.85

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_3 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_5 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(421091031).content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 34 <= 0 and var_133_4 or var_133_4 * (utf8.len(var_133_5) / 34)

				if (34 <= 0 and var_133_4 or var_133_4 * (utf8.len(var_133_5) / 34)) > 0 and var_133_4 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_3 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_3
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_4, arg_130_1.talkMaxDuration)

			if var_133_3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_3 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_3) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_3 + var_133_8 and arg_130_1.time_ < var_133_3 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play421091032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 421091032
		arg_134_1.duration_ = 3.07

		local var_134_0 = {
			zh = 2.9,
			ja = 3.066
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play421091033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10102ui_story = arg_134_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).z)
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles = arg_134_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_134_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10102ui_story"].transform.position).z)
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["10102ui_story"].transform.localEulerAngles = arg_134_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["10102ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect10102ui_story == nil then
				arg_134_1.var_.characterEffect10102ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect10102ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect10102ui_story then
				arg_134_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_4 = 0
			local var_137_5 = 0.35

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(421091032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 14 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 14)

				if (14 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 14)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091032", "story_v_out_421091.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091032", "story_v_out_421091.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_421091", "421091032", "story_v_out_421091.awb")

						arg_134_1:RecordAudio("421091032", var_137_11)
						arg_134_1:RecordAudio("421091032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_421091", "421091032", "story_v_out_421091.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_421091", "421091032", "story_v_out_421091.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play421091033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 421091033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play421091034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10102ui_story = arg_138_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).z)
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles = arg_138_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).z)
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles = arg_138_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_141_1 = 0
			local var_141_2 = 0.875

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(421091033).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 31 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 31)

				if (31 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 31)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play421091034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 421091034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play421091035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_145_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_2 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_2

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_2
						arg_142_1.bgmTxt2_.text = var_145_2
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_145_3 = 0
			local var_145_4 = 0.3

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_5 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(421091034).content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 12 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 12)

				if (12 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 12)) > 0 and var_145_4 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_3 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_3
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_4, arg_142_1.talkMaxDuration)

			if var_145_3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_3 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_3) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_3 + var_145_8 and arg_142_1.time_ < var_145_3 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play421091035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421091035
		arg_147_1.duration_ = 3.4

		local var_147_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_147_0:Play421091036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = arg_147_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1047ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1047ui_story == nil then
				arg_147_1.var_.characterEffect1047ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1047ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1047ui_story then
				arg_147_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_150_4 = 0
			local var_150_5 = 0.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(421091035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 7 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 7)

				if (7 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 7)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091035", "story_v_out_421091.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091035", "story_v_out_421091.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_421091", "421091035", "story_v_out_421091.awb")

						arg_147_1:RecordAudio("421091035", var_150_11)
						arg_147_1:RecordAudio("421091035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_421091", "421091035", "story_v_out_421091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_421091", "421091035", "story_v_out_421091.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421091036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421091037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1047ui_story"]) and arg_151_1.var_.characterEffect1047ui_story == nil then
				arg_151_1.var_.characterEffect1047ui_story = arg_151_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1047ui_story"]) then
				if arg_151_1.var_.characterEffect1047ui_story and not isNil(arg_151_1.actors_["1047ui_story"]) then
					arg_151_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1047ui_story"]) and arg_151_1.var_.characterEffect1047ui_story then
				arg_151_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.15

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(421091036).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 6 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 6)

				if (6 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 6)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play421091037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421091037
		arg_155_1.duration_ = 1

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"

			SetActive(arg_155_1.choicesGo_, true)

			for iter_156_0, iter_156_1 in ipairs(arg_155_1.choices_) do
				SetActive(iter_156_1.go, iter_156_0 <= 2)
			end

			arg_155_1.choices_[1].txt.text = arg_155_1:FormatText(StoryChoiceCfg[1353].name)
			arg_155_1.choices_[2].txt.text = arg_155_1:FormatText(StoryChoiceCfg[1354].name)
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421091038(arg_155_1)
			end

			if arg_157_0 == 2 then
				arg_155_0:Play421091038(arg_155_1)
			end

			arg_155_1:RecordChoiceLog(421091037, 1353, 1354)
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			return
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play421091038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421091038
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421091039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1047ui_story = arg_159_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).z)
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles = arg_159_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_159_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).z)
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles = arg_159_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1047ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1047ui_story == nil then
				arg_159_1.var_.characterEffect1047ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1047ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1047ui_story then
				arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_162_4 = "1047ui_story"

			if arg_159_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_162_5 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_159_1.stage_.transform)

				var_162_5.name = var_162_4
				var_162_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_[var_162_4] = var_162_5

				local var_162_6 = var_162_5:GetComponentInChildren(typeof(CharacterEffect))

				var_162_6.enabled = true

				local var_162_7 = GameObjectTools.GetOrAddComponent(var_162_5, typeof(DynamicBoneHelper))

				if var_162_7 then
					var_162_7:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_6.transform, false)

				arg_159_1.var_[var_162_4 .. "Animator"] = var_162_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_[var_162_4 .. "Animator"].applyRootMotion = true
				arg_159_1.var_[var_162_4 .. "LipSync"] = var_162_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_162_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_10 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_10

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_10
						arg_159_1.bgmTxt2_.text = var_162_10
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 0.433333333333333 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_162_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_13 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_13

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_13
						arg_159_1.bgmTxt2_.text = var_162_13
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_14 = 0
			local var_162_15 = 0.05

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_16 = arg_159_1:GetWordFromCfg(421091038)
				local var_162_17 = arg_159_1:FormatText(var_162_16.content)

				arg_159_1.text_.text = var_162_17

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_19 = 2 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_17) / 2)

				if (2 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_17) / 2)) > 0 and var_162_15 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_14
					end
				end

				arg_159_1.text_.text = var_162_17
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091038", "story_v_out_421091.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_421091", "421091038", "story_v_out_421091.awb") / 1000

					if var_162_20 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_14
					end

					if var_162_16.prefab_name ~= "" and arg_159_1.actors_[var_162_16.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_16.prefab_name].transform, "story_v_out_421091", "421091038", "story_v_out_421091.awb")

						arg_159_1:RecordAudio("421091038", var_162_21)
						arg_159_1:RecordAudio("421091038", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421091", "421091038", "story_v_out_421091.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421091", "421091038", "story_v_out_421091.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_15, arg_159_1.talkMaxDuration)

			if var_162_14 <= arg_159_1.time_ and arg_159_1.time_ < var_162_14 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_14) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_14 + var_162_22 and arg_159_1.time_ < var_162_14 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421091039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421091040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1047ui_story = arg_165_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).z)
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles = arg_165_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1047ui_story"].transform.position).z)
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1047ui_story"].transform.localEulerAngles = arg_165_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_168_1 = 0
			local var_168_2 = 1.275

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

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(421091039).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 51 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 51)

				if (51 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 51)) > 0 and var_168_2 < var_168_5 then
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

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421091040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play421091041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(421091040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 15 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 15)

				if (15 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 15)) > 0 and var_172_0 < var_172_3 then
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
	Play421091041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421091041
		arg_173_1.duration_ = 16.4

		local var_173_0 = {
			zh = 13.166,
			ja = 16.4
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
				arg_173_0:Play421091042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047ui_story = arg_173_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1047ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_176_4 = 0
			local var_176_5 = 1.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(421091041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 50 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 50)

				if (50 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 50)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091041", "story_v_out_421091.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091041", "story_v_out_421091.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_421091", "421091041", "story_v_out_421091.awb")

						arg_173_1:RecordAudio("421091041", var_176_11)
						arg_173_1:RecordAudio("421091041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421091", "421091041", "story_v_out_421091.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421091", "421091041", "story_v_out_421091.awb")
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

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421091042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play421091043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = arg_177_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_180_1 = 0
			local var_180_2 = 1.275

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(421091042).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 21 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 21)

				if (21 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 21)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421091043
		arg_181_1.duration_ = 23.73

		local var_181_0 = {
			zh = 18.166,
			ja = 23.733
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
				arg_181_0:Play421091044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1047ui_story = arg_181_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).z)
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles = arg_181_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_181_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).z)
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles = arg_181_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1047ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1047ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1047ui_story then
				arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_184_4 = 0
			local var_184_5 = 1.525

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(421091043)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 61 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 61)

				if (61 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 61)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091043", "story_v_out_421091.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091043", "story_v_out_421091.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_421091", "421091043", "story_v_out_421091.awb")

						arg_181_1:RecordAudio("421091043", var_184_11)
						arg_181_1:RecordAudio("421091043", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421091", "421091043", "story_v_out_421091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421091", "421091043", "story_v_out_421091.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421091044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play421091045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = arg_185_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1047ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story == nil then
				arg_185_1.var_.characterEffect1047ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1047ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_2)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story then
				arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_188_3 = 0
			local var_188_4 = 0.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_5 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(421091044).content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 14 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 14)

				if (14 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 14)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_8 and arg_185_1.time_ < var_188_3 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421091045
		arg_189_1.duration_ = 18.03

		local var_189_0 = {
			zh = 14.2,
			ja = 18.033
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
				arg_189_0:Play421091046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1047ui_story = arg_189_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1047ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1047ui_story == nil then
				arg_189_1.var_.characterEffect1047ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1047ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1047ui_story then
				arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 1.35

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(421091045)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 53 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 53)

				if (53 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 53)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091045", "story_v_out_421091.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091045", "story_v_out_421091.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_421091", "421091045", "story_v_out_421091.awb")

						arg_189_1:RecordAudio("421091045", var_192_11)
						arg_189_1:RecordAudio("421091045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_421091", "421091045", "story_v_out_421091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_421091", "421091045", "story_v_out_421091.awb")
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
				actorName = "1047ui_story",
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
	Play421091046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421091046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421091047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1047ui_story"]) and arg_193_1.var_.characterEffect1047ui_story == nil then
				arg_193_1.var_.characterEffect1047ui_story = arg_193_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1047ui_story"]) then
				if arg_193_1.var_.characterEffect1047ui_story and not isNil(arg_193_1.actors_["1047ui_story"]) then
					arg_193_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1047ui_story"]) and arg_193_1.var_.characterEffect1047ui_story then
				arg_193_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(421091046).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 9 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 9)

				if (9 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 9)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play421091047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421091047
		arg_197_1.duration_ = 8.6

		local var_197_0 = {
			zh = 6.6,
			ja = 8.6
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
				arg_197_0:Play421091048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1047ui_story = arg_197_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).z)
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles = arg_197_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_197_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1047ui_story"].transform.position).z)
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1047ui_story"].transform.localEulerAngles = arg_197_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1047ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1047ui_story == nil then
				arg_197_1.var_.characterEffect1047ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1047ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1047ui_story then
				arg_197_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_200_4 = 0
			local var_200_5 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(421091047)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 27 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 27)

				if (27 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 27)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091047", "story_v_out_421091.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091047", "story_v_out_421091.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_421091", "421091047", "story_v_out_421091.awb")

						arg_197_1:RecordAudio("421091047", var_200_11)
						arg_197_1:RecordAudio("421091047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421091", "421091047", "story_v_out_421091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421091", "421091047", "story_v_out_421091.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421091048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play421091049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1047ui_story"]) and arg_201_1.var_.characterEffect1047ui_story == nil then
				arg_201_1.var_.characterEffect1047ui_story = arg_201_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1047ui_story"]) then
				if arg_201_1.var_.characterEffect1047ui_story and not isNil(arg_201_1.actors_["1047ui_story"]) then
					arg_201_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1047ui_story"]) and arg_201_1.var_.characterEffect1047ui_story then
				arg_201_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.425

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(421091048).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 17 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 17)

				if (17 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 17)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play421091049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421091049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421091050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.325

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(421091049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 53 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 53)

				if (53 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 53)) > 0 and var_208_0 < var_208_3 then
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
	Play421091050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421091050
		arg_209_1.duration_ = 7.6

		local var_209_0 = {
			zh = 5.066,
			ja = 7.6
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
				arg_209_0:Play421091051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = arg_209_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1047ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_212_4 = 0
			local var_212_5 = 0.475

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(421091050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 19 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 19)

				if (19 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 19)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091050", "story_v_out_421091.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091050", "story_v_out_421091.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_421091", "421091050", "story_v_out_421091.awb")

						arg_209_1:RecordAudio("421091050", var_212_11)
						arg_209_1:RecordAudio("421091050", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421091", "421091050", "story_v_out_421091.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421091", "421091050", "story_v_out_421091.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421091051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play421091052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1047ui_story"]) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = arg_213_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1047ui_story"]) then
				if arg_213_1.var_.characterEffect1047ui_story and not isNil(arg_213_1.actors_["1047ui_story"]) then
					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1047ui_story"]) and arg_213_1.var_.characterEffect1047ui_story then
				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 1.025

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(421091051).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 42 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 42)

				if (42 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 42)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play421091052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421091052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421091053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.325

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

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(421091052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 53 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 53)

				if (53 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 53)) > 0 and var_220_0 < var_220_3 then
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
	Play421091053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421091053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421091054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1047ui_story = arg_221_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).z)
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles = arg_221_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1047ui_story"].transform.position).z)
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1047ui_story"].transform.localEulerAngles = arg_221_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_224_1 = 0
			local var_224_2 = 0.85

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(421091053).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 34 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 34)

				if (34 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 34)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421091054
		arg_225_1.duration_ = 4.87

		local var_225_0 = {
			zh = 3.533,
			ja = 4.866
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
				arg_225_0:Play421091055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = arg_225_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1047ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1047ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_4 = 0
			local var_228_5 = 0.4

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(421091054)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 16 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 16)

				if (16 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 16)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091054", "story_v_out_421091.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091054", "story_v_out_421091.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_421091", "421091054", "story_v_out_421091.awb")

						arg_225_1:RecordAudio("421091054", var_228_11)
						arg_225_1:RecordAudio("421091054", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421091", "421091054", "story_v_out_421091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421091", "421091054", "story_v_out_421091.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421091055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421091056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1047ui_story"]) and arg_229_1.var_.characterEffect1047ui_story == nil then
				arg_229_1.var_.characterEffect1047ui_story = arg_229_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1047ui_story"]) then
				if arg_229_1.var_.characterEffect1047ui_story and not isNil(arg_229_1.actors_["1047ui_story"]) then
					arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1047ui_story"]) and arg_229_1.var_.characterEffect1047ui_story then
				arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.6

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
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

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(421091055).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 24 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 24)

				if (24 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 24)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play421091056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 421091056
		arg_233_1.duration_ = 4.63

		local var_233_0 = {
			zh = 3.166,
			ja = 4.633
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
				arg_233_0:Play421091057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047ui_story = arg_233_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).z)
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles = arg_233_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_233_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1047ui_story"].transform.position).z)
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1047ui_story"].transform.localEulerAngles = arg_233_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1047ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1047ui_story == nil then
				arg_233_1.var_.characterEffect1047ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1047ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1047ui_story then
				arg_233_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_236_4 = 0
			local var_236_5 = 0.325

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(421091056)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 13 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 13)

				if (13 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 13)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091056", "story_v_out_421091.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091056", "story_v_out_421091.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_421091", "421091056", "story_v_out_421091.awb")

						arg_233_1:RecordAudio("421091056", var_236_11)
						arg_233_1:RecordAudio("421091056", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_421091", "421091056", "story_v_out_421091.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_421091", "421091056", "story_v_out_421091.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play421091057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 421091057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play421091058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1047ui_story"]) and arg_237_1.var_.characterEffect1047ui_story == nil then
				arg_237_1.var_.characterEffect1047ui_story = arg_237_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1047ui_story"]) then
				if arg_237_1.var_.characterEffect1047ui_story and not isNil(arg_237_1.actors_["1047ui_story"]) then
					arg_237_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1047ui_story"]) and arg_237_1.var_.characterEffect1047ui_story then
				arg_237_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(421091057).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 5 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 5)

				if (5 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 5)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play421091058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 421091058
		arg_241_1.duration_ = 2.97

		local var_241_0 = {
			zh = 2.4,
			ja = 2.966
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play421091059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1047ui_story = arg_241_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).z)
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles = arg_241_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1047ui_story"].transform.position).z)
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1047ui_story"].transform.localEulerAngles = arg_241_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_244_1 = 0
			local var_244_2 = 0.325

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(421091058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 13 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 13)

				if (13 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 13)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091058", "story_v_out_421091.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_out_421091", "421091058", "story_v_out_421091.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_421091", "421091058", "story_v_out_421091.awb")

						arg_241_1:RecordAudio("421091058", var_244_8)
						arg_241_1:RecordAudio("421091058", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_421091", "421091058", "story_v_out_421091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_421091", "421091058", "story_v_out_421091.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play421091059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421091059
		arg_245_1.duration_ = 3.87

		local var_245_0 = {
			zh = 2.7,
			ja = 3.866
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play421091060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1047ui_story = arg_245_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).z)
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles = arg_245_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_245_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1047ui_story"].transform.position).z)
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1047ui_story"].transform.localEulerAngles = arg_245_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1047ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1047ui_story == nil then
				arg_245_1.var_.characterEffect1047ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1047ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1047ui_story then
				arg_245_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_248_4 = arg_245_1.actors_["10102ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10102ui_story == nil then
				arg_245_1.var_.characterEffect10102ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_5 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 and not isNil(var_248_4) then
				if arg_245_1.var_.characterEffect10102ui_story and not isNil(var_248_4) then
					arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_5)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10102ui_story then
				arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_248_6 = 0
			local var_248_7 = 0.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(421091059)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 9 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 9)

				if (9 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 9)) > 0 and var_248_7 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091059", "story_v_out_421091.awb") ~= 0 then
					local var_248_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091059", "story_v_out_421091.awb") / 1000

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end

					if var_248_8.prefab_name ~= "" and arg_245_1.actors_[var_248_8.prefab_name] ~= nil then
						local var_248_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_8.prefab_name].transform, "story_v_out_421091", "421091059", "story_v_out_421091.awb")

						arg_245_1:RecordAudio("421091059", var_248_13)
						arg_245_1:RecordAudio("421091059", var_248_13)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_421091", "421091059", "story_v_out_421091.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_421091", "421091059", "story_v_out_421091.awb")
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
				actorName = "1047ui_story",
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
	Play421091060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421091060
		arg_249_1.duration_ = 9.47

		local var_249_0 = {
			zh = 5.633,
			ja = 9.466
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play421091061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10143ui_story = arg_249_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).z)
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles = arg_249_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_249_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).z)
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles = arg_249_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1047ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1047ui_story = var_252_1.localPosition
			end

			local var_252_2 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 then
				var_252_1.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_249_1.time_ - 0) / var_252_2)
				var_252_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_1.position).x, (manager.ui.mainCamera.transform.position - var_252_1.position).y, (manager.ui.mainCamera.transform.position - var_252_1.position).z)
				var_252_1.localEulerAngles.z = 0
				var_252_1.localEulerAngles.x = 0
				var_252_1.localEulerAngles = var_252_1.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 then
				var_252_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_252_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_1.position).x, (manager.ui.mainCamera.transform.position - var_252_1.position).y, (manager.ui.mainCamera.transform.position - var_252_1.position).z)
				var_252_1.localEulerAngles.z = 0
				var_252_1.localEulerAngles.x = 0
				var_252_1.localEulerAngles = var_252_1.localEulerAngles
			end

			local var_252_3 = arg_249_1.actors_["10143ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10143ui_story == nil then
				arg_249_1.var_.characterEffect10143ui_story = var_252_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 and not isNil(var_252_3) then
				if arg_249_1.var_.characterEffect10143ui_story and not isNil(var_252_3) then
					arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10143ui_story then
				arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_252_6 = arg_249_1.actors_["1047ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1047ui_story == nil then
				arg_249_1.var_.characterEffect1047ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 and not isNil(var_252_6) then
				if arg_249_1.var_.characterEffect1047ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_7)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1047ui_story then
				arg_249_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_252_8 = 0
			local var_252_9 = 0.75

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(421091060)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 30 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 30)

				if (30 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 30)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091060", "story_v_out_421091.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_421091", "421091060", "story_v_out_421091.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_421091", "421091060", "story_v_out_421091.awb")

						arg_249_1:RecordAudio("421091060", var_252_15)
						arg_249_1:RecordAudio("421091060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_421091", "421091060", "story_v_out_421091.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_421091", "421091060", "story_v_out_421091.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play421091061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421091061
		arg_253_1.duration_ = 12.3

		local var_253_0 = {
			zh = 9.633,
			ja = 12.3
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play421091062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1047ui_story = arg_253_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1047ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1047ui_story == nil then
				arg_253_1.var_.characterEffect1047ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1047ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1047ui_story then
				arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["10143ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10143ui_story == nil then
				arg_253_1.var_.characterEffect10143ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_5 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 and not isNil(var_256_4) then
				if arg_253_1.var_.characterEffect10143ui_story and not isNil(var_256_4) then
					arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_5)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10143ui_story then
				arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_6 = 0
			local var_256_7 = 0.95

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(421091061)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 38 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 38)

				if (38 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 38)) > 0 and var_256_7 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091061", "story_v_out_421091.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091061", "story_v_out_421091.awb") / 1000

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_out_421091", "421091061", "story_v_out_421091.awb")

						arg_253_1:RecordAudio("421091061", var_256_13)
						arg_253_1:RecordAudio("421091061", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421091", "421091061", "story_v_out_421091.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421091", "421091061", "story_v_out_421091.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play421091062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 421091062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play421091063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1047ui_story = arg_257_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).z)
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles = arg_257_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1047ui_story"].transform.position).z)
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1047ui_story"].transform.localEulerAngles = arg_257_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["10143ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10143ui_story = var_260_1.localPosition
			end

			local var_260_2 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 then
				var_260_1.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_2)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 then
				var_260_1.localPosition = Vector3.New(0, 100, 0)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if 0.1 < arg_257_1.time_ and arg_257_1.time_ <= 0.1 + arg_260_0 then
				arg_257_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_bag01", "")
			end

			local var_260_4 = 0
			local var_260_5 = 0.925

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(421091062).content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 37 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 37)

				if (37 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 37)) > 0 and var_260_5 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_9 and arg_257_1.time_ < var_260_4 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play421091063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421091063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play421091064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(421091063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 13 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 13)

				if (13 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 13)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play421091064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421091064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play421091065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(421091064).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 42)

				if (42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 42)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play421091065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421091065
		arg_269_1.duration_ = 5.2

		local var_269_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play421091066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10143ui_story = arg_269_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).z)
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles = arg_269_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_269_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10143ui_story"].transform.position).z)
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10143ui_story"].transform.localEulerAngles = arg_269_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["10143ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10143ui_story == nil then
				arg_269_1.var_.characterEffect10143ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect10143ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10143ui_story then
				arg_269_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.575

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(421091065)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 23 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 23)

				if (23 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 23)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091065", "story_v_out_421091.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091065", "story_v_out_421091.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_421091", "421091065", "story_v_out_421091.awb")

						arg_269_1:RecordAudio("421091065", var_272_11)
						arg_269_1:RecordAudio("421091065", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421091", "421091065", "story_v_out_421091.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421091", "421091065", "story_v_out_421091.awb")
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
				actorName = "10143ui_story",
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
	Play421091066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421091066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421091067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10143ui_story"]) and arg_273_1.var_.characterEffect10143ui_story == nil then
				arg_273_1.var_.characterEffect10143ui_story = arg_273_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10143ui_story"]) then
				if arg_273_1.var_.characterEffect10143ui_story and not isNil(arg_273_1.actors_["10143ui_story"]) then
					arg_273_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10143ui_story"]) and arg_273_1.var_.characterEffect10143ui_story then
				arg_273_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.825

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

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(421091066).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 33 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 33)

				if (33 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 33)) > 0 and var_276_2 < var_276_5 then
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
	Play421091067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421091067
		arg_277_1.duration_ = 9.7

		local var_277_0 = {
			zh = 7.866,
			ja = 9.7
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play421091068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1047ui_story = arg_277_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).z)
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles = arg_277_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_277_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).z)
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles = arg_277_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10143ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10143ui_story = var_280_1.localPosition
			end

			local var_280_2 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 then
				var_280_1.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_277_1.time_ - 0) / var_280_2)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 then
				var_280_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			local var_280_3 = arg_277_1.actors_["1047ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect1047ui_story == nil then
				arg_277_1.var_.characterEffect1047ui_story = var_280_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_4 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 and not isNil(var_280_3) then
				if arg_277_1.var_.characterEffect1047ui_story and not isNil(var_280_3) then
					arg_277_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect1047ui_story then
				arg_277_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 1.05

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(421091067)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 42 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 42)

				if (42 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 42)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091067", "story_v_out_421091.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091067", "story_v_out_421091.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_421091", "421091067", "story_v_out_421091.awb")

						arg_277_1:RecordAudio("421091067", var_280_13)
						arg_277_1:RecordAudio("421091067", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_421091", "421091067", "story_v_out_421091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_421091", "421091067", "story_v_out_421091.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play421091068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421091068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421091069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1047ui_story"]) and arg_281_1.var_.characterEffect1047ui_story == nil then
				arg_281_1.var_.characterEffect1047ui_story = arg_281_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1047ui_story"]) then
				if arg_281_1.var_.characterEffect1047ui_story and not isNil(arg_281_1.actors_["1047ui_story"]) then
					arg_281_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1047ui_story"]) and arg_281_1.var_.characterEffect1047ui_story then
				arg_281_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 1.025

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(421091068).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 41 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 41)

				if (41 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 41)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play421091069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421091069
		arg_285_1.duration_ = 2.1

		local var_285_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_285_0:Play421091070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10143ui_story = arg_285_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).z)
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles = arg_285_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_285_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10143ui_story"].transform.position).z)
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10143ui_story"].transform.localEulerAngles = arg_285_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["10143ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10143ui_story == nil then
				arg_285_1.var_.characterEffect10143ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect10143ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10143ui_story then
				arg_285_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.075

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(421091069)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 3 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 3)

				if (3 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 3)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091069", "story_v_out_421091.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091069", "story_v_out_421091.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_421091", "421091069", "story_v_out_421091.awb")

						arg_285_1:RecordAudio("421091069", var_288_11)
						arg_285_1:RecordAudio("421091069", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_421091", "421091069", "story_v_out_421091.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_421091", "421091069", "story_v_out_421091.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421091070
		arg_289_1.duration_ = 2

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421091071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10102ui_story = arg_289_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).z)
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles = arg_289_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_289_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10102ui_story"].transform.position).z)
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10102ui_story"].transform.localEulerAngles = arg_289_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1047ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1047ui_story = var_292_1.localPosition
			end

			local var_292_2 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 then
				var_292_1.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_2)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 then
				var_292_1.localPosition = Vector3.New(0, 100, 0)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			local var_292_3 = arg_289_1.actors_["10102ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect10102ui_story == nil then
				arg_289_1.var_.characterEffect10102ui_story = var_292_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_4 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 and not isNil(var_292_3) then
				if arg_289_1.var_.characterEffect10102ui_story and not isNil(var_292_3) then
					arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect10102ui_story then
				arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_292_6 = arg_289_1.actors_["10143ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_6) and arg_289_1.var_.characterEffect10143ui_story == nil then
				arg_289_1.var_.characterEffect10143ui_story = var_292_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_7 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 and not isNil(var_292_6) then
				if arg_289_1.var_.characterEffect10143ui_story and not isNil(var_292_6) then
					arg_289_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_7)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 and not isNil(var_292_6) and arg_289_1.var_.characterEffect10143ui_story then
				arg_289_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_8 = 0
			local var_292_9 = 0.2

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(421091070)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 8 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 8)

				if (8 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 8)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091070", "story_v_out_421091.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_421091", "421091070", "story_v_out_421091.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_421091", "421091070", "story_v_out_421091.awb")

						arg_289_1:RecordAudio("421091070", var_292_15)
						arg_289_1:RecordAudio("421091070", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421091", "421091070", "story_v_out_421091.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421091", "421091070", "story_v_out_421091.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_16 and arg_289_1.time_ < var_292_8 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421091071
		arg_293_1.duration_ = 9.9

		local var_293_0 = {
			zh = 5.7,
			ja = 9.9
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play421091072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10143ui_story = arg_293_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).z)
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles = arg_293_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_293_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10143ui_story"].transform.position).z)
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10143ui_story"].transform.localEulerAngles = arg_293_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["10143ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10143ui_story == nil then
				arg_293_1.var_.characterEffect10143ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect10143ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10143ui_story then
				arg_293_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["10102ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10102ui_story == nil then
				arg_293_1.var_.characterEffect10102ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_5 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 and not isNil(var_296_4) then
				if arg_293_1.var_.characterEffect10102ui_story and not isNil(var_296_4) then
					arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_5)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10102ui_story then
				arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_6 = 0
			local var_296_7 = 0.7

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(421091071)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 28 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 28)

				if (28 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 28)) > 0 and var_296_7 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091071", "story_v_out_421091.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_421091", "421091071", "story_v_out_421091.awb") / 1000

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_421091", "421091071", "story_v_out_421091.awb")

						arg_293_1:RecordAudio("421091071", var_296_13)
						arg_293_1:RecordAudio("421091071", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421091", "421091071", "story_v_out_421091.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421091", "421091071", "story_v_out_421091.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play421091072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421091072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421091073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10143ui_story = arg_297_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).z)
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles = arg_297_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10143ui_story"].transform.position).z)
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10143ui_story"].transform.localEulerAngles = arg_297_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["10102ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10102ui_story = var_300_1.localPosition
			end

			local var_300_2 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 then
				var_300_1.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_2)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 then
				var_300_1.localPosition = Vector3.New(0, 100, 0)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			local var_300_3 = 0
			local var_300_4 = 0.775

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_5 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(421091072).content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 31 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 31)

				if (31 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 31)) > 0 and var_300_4 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_3
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_4, arg_297_1.talkMaxDuration)

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_3) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_3 + var_300_8 and arg_297_1.time_ < var_300_3 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play421091073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421091073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
			arg_301_1.auto_ = false
		end

		function arg_301_1.playNext_(arg_303_0)
			arg_301_1.onStoryFinished_()
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.65

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(421091073).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 26 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 26)

				if (26 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 26)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D12a"
	},
	voices = {
		"story_v_out_421091.awb"
	}
}
